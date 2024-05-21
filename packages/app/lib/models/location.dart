// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:p2panda/p2panda.dart';

import 'package:app/io/p2panda/publish.dart';
import 'package:app/models/base.dart';
import 'package:app/models/schema_ids.dart';

const BOX_RESULTS_KEY = 'locationBox';
const BUILDING_RESULTS_KEY = 'locationBuilding';
const GROUND_RESULTS_KEY = 'locationGround';
const TREE_RESULTS_KEY = 'locationTree';

enum LocationType {
  Box,
  Building,
  Ground,
  Tree,
}

/*
 * Generic location methods across all location types
 */

class Location {
  final DocumentId id;
  DocumentViewId viewId;

  final LocationType type;
  final DocumentId sightingId;
  String? treeSpecies;
  double? height;
  double? diameter;

  Location({
    required this.id,
    required this.viewId,
    required this.type,
    required this.sightingId,
    this.treeSpecies,
    this.height,
    this.diameter,
  });

  factory Location.fromJson(LocationType type, Map<String, dynamic> result) {
    String? treeSpecies;
    double? height;
    double? diameter;

    if (type == LocationType.Tree) {
      // Values are not nullable in p2panda schemas
      treeSpecies = result['fields']['tree_species'] as String;
      height = result['fields']['height'] as double;
      diameter = result['fields']['diameter'] as double;

      // .. so we do that afterwards
      if (treeSpecies.isEmpty) {
        treeSpecies = null;
      }

      if (height == 0.0) {
        height = null;
      }

      if (diameter == 0.0) {
        diameter = null;
      }
    }

    return Location(
      id: result['meta']['documentId'] as DocumentId,
      viewId: result['meta']['viewId'] as DocumentViewId,
      type: type,
      sightingId:
          result['fields']['sighting']['meta']['documentId'] as DocumentId,
      treeSpecies: treeSpecies,
      height: height,
      diameter: diameter,
    );
  }

  static Future<Location> create(
      {required LocationType type,
      required DocumentId sightingId,
      String? treeSpecies,
      double? height,
      double? diameter}) async {
    DocumentViewId? viewId;

    if (type == LocationType.Tree) {
      viewId = await createLocationTree(
          sightingId: sightingId,
          treeSpecies: treeSpecies,
          height: height,
          diameter: diameter);
    } else if (type == LocationType.Box) {
      viewId = await createLocationBox(sightingId: sightingId);
    } else if (type == LocationType.Ground) {
      viewId = await createLocationGround(sightingId: sightingId);
    } else if (type == LocationType.Building) {
      viewId = await createLocationBuilding(sightingId: sightingId);
    }

    return Location(
      id: viewId!,
      viewId: viewId,
      type: type,
      sightingId: sightingId,
      treeSpecies: treeSpecies,
      height: height,
      diameter: diameter,
    );
  }

  Future<DocumentViewId> update(
      {String? treeSpecies, double? height, double? diameter}) async {
    if (type != LocationType.Tree) {
      throw "Can only update locations of type 'tree'";
    }

    viewId = await updateLocationTree(viewId,
        treeSpecies: treeSpecies, height: height, diameter: diameter);

    if (treeSpecies != null) {
      this.treeSpecies = treeSpecies.isEmpty ? null : treeSpecies;
    }

    if (height != null) {
      this.height = height == 0.0 ? null : height;
    }

    if (diameter != null) {
      this.diameter = diameter == 0.0 ? null : diameter;
    }

    return viewId;
  }

  Future<DocumentViewId> delete() async {
    if (type == LocationType.Tree) {
      viewId = await deleteLocationTree(viewId);
    } else if (type == LocationType.Box) {
      viewId = await deleteLocationBox(viewId);
    } else if (type == LocationType.Ground) {
      viewId = await deleteLocationGround(viewId);
    } else if (type == LocationType.Building) {
      viewId = await deleteLocationBuilding(viewId);
    }
    return viewId;
  }
}

String locationQuery(DocumentId sightingId) {
  const locationBoxSchemaId = SchemaIds.bee_attributes_location_box;
  const locationBuildingSchemaId = SchemaIds.bee_attributes_location_building;
  const locationGroundSchemaId = SchemaIds.bee_attributes_location_ground;
  const locationTreeSchemaId = SchemaIds.bee_attributes_location_tree;

  String parameters = '''
    first: 1,
    filter: {
      sighting: { eq: "$sightingId" },
    },
  ''';

  // Our data-model allows attaching multiple locations to a sighting, but in
  // our UI we're only displaying one of them. This query checks for all
  // location types first and we handle selecting one later
  return '''
    query GetLocationForSighting {
      $BOX_RESULTS_KEY: all_$locationBoxSchemaId($parameters) {
        documents {
          $locationBoxFields
        }
      }
      $BUILDING_RESULTS_KEY: all_$locationBuildingSchemaId($parameters) {
        documents {
          $locationBuildingFields
        }
      }
      $GROUND_RESULTS_KEY: all_$locationGroundSchemaId($parameters) {
        documents {
          $locationGroundFields
        }
      }
      $TREE_RESULTS_KEY: all_$locationTreeSchemaId($parameters) {
        documents {
          $locationTreeFields
        }
      }
    }
  ''';
}

// Expects multiple results from a multi-query GraphQL request over all
// location types. This method will automatically select one of them based
// on deterministic rules as the UI can only display one location at a time
// for sightings.
Location? getLocationFromResults(Map<String, dynamic> result) {
  var boxLocations = result[BOX_RESULTS_KEY]['documents'] as List;
  var buildingLocations = result[BUILDING_RESULTS_KEY]['documents'] as List;
  var groundLocations = result[GROUND_RESULTS_KEY]['documents'] as List;
  var treeLocations = result[TREE_RESULTS_KEY]['documents'] as List;

  if (boxLocations.isNotEmpty) {
    return Location.fromJson(
        LocationType.Box, boxLocations[0] as Map<String, dynamic>);
  }

  if (buildingLocations.isNotEmpty) {
    return Location.fromJson(
        LocationType.Building, buildingLocations[0] as Map<String, dynamic>);
  }

  if (groundLocations.isNotEmpty) {
    return Location.fromJson(
        LocationType.Ground, groundLocations[0] as Map<String, dynamic>);
  }

  if (treeLocations.isNotEmpty) {
    return Location.fromJson(
        LocationType.Tree, treeLocations[0] as Map<String, dynamic>);
  }

  return null;
}

/*
 * Location: Tree
 */

String get locationTreeFields {
  return '''
    $metaFields
    fields {
      tree_species
      height
      diameter
      sighting {
        meta {
          documentId
        }
      }
    }
  ''';
}

Future<DocumentViewId> createLocationTree(
    {required DocumentId sightingId,
    String? treeSpecies,
    double? height,
    double? diameter}) async {
  List<(String, OperationValue)> fields = [
    ("tree_species", OperationValue.string(treeSpecies ?? "")),
    ("height", OperationValue.float(height ?? 0.0)),
    ("diameter", OperationValue.float(diameter ?? 0.0)),
    ("sighting", OperationValue.relation(sightingId)),
  ];
  return await create(SchemaIds.bee_attributes_location_tree, fields);
}

Future<DocumentViewId> updateLocationTree(DocumentViewId viewId,
    {String? treeSpecies, double? height, double? diameter}) async {
  List<(String, OperationValue)> fields = [];

  if (treeSpecies != null) {
    fields.add(("tree_species", OperationValue.string(treeSpecies)));
  }

  if (height != null) {
    fields.add(("height", OperationValue.float(height)));
  }

  if (diameter != null) {
    fields.add(("diameter", OperationValue.float(diameter)));
  }

  return await update(SchemaIds.bee_attributes_location_tree, viewId, fields);
}

Future<DocumentViewId> deleteLocationTree(DocumentViewId viewId) async {
  return await delete(SchemaIds.bee_attributes_location_tree, viewId);
}

/*
 * Location: Box
 */

String get locationBoxFields {
  return '''
    $metaFields
    fields {
      sighting {
        meta {
          documentId
        }
      }
    }
  ''';
}

Future<DocumentViewId> createLocationBox({
  required DocumentId sightingId,
}) async {
  List<(String, OperationValue)> fields = [
    ("sighting", OperationValue.relation(sightingId)),
  ];
  return await create(SchemaIds.bee_attributes_location_box, fields);
}

Future<DocumentViewId> deleteLocationBox(DocumentViewId viewId) async {
  return await delete(SchemaIds.bee_attributes_location_box, viewId);
}

/*
 * Location: Building
 */

String get locationBuildingFields {
  return '''
    $metaFields
    fields {
      sighting {
        meta {
          documentId
        }
      }
    }
  ''';
}

Future<DocumentViewId> createLocationBuilding({
  required DocumentId sightingId,
}) async {
  List<(String, OperationValue)> fields = [
    ("sighting", OperationValue.relation(sightingId)),
  ];
  return await create(SchemaIds.bee_attributes_location_building, fields);
}

Future<DocumentViewId> deleteLocationBuilding(DocumentViewId viewId) async {
  return await delete(SchemaIds.bee_attributes_location_building, viewId);
}

/*
 * Location: Ground
 */

String get locationGroundFields {
  return '''
    $metaFields
    fields {
      sighting {
        meta {
          documentId
        }
      }
    }
  ''';
}

Future<DocumentViewId> createLocationGround({
  required DocumentId sightingId,
}) async {
  List<(String, OperationValue)> fields = [
    ("sighting", OperationValue.relation(sightingId)),
  ];
  return await create(SchemaIds.bee_attributes_location_ground, fields);
}

Future<DocumentViewId> deleteLocationGround(DocumentViewId viewId) async {
  return await delete(SchemaIds.bee_attributes_location_ground, viewId);
}
