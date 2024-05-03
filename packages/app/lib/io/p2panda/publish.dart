// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:convert/convert.dart';
import 'package:p2panda_flutter/p2panda_flutter.dart';

import 'package:app/io/graphql/queries.dart' as queries;
import 'package:app/io/p2panda/key_pair.dart';
import 'package:app/io/p2panda/p2panda.dart';
import 'package:app/io/p2panda/schemas.dart';

/// Name of an operation field.
typedef FieldName = String;

/// List of operation fields, representing actual application data.
typedef OperationFields = List<(FieldName, OperationValue)>;

/// Document view id represented as a string.
typedef DocumentViewId = String;

/// Document id represented as a string.
typedef DocumentId = String;

/// Generates and publishes a CREATE operation on the p2panda node.
Future<DocumentViewId> create(SchemaId schemaId, OperationFields fields) async {
  return await _publish(OperationAction.Create, schemaId, fields, null);
}

/// Generates and publishes an UPDATE operation on the p2panda node.
Future<DocumentViewId> update(
    SchemaId schemaId, DocumentViewId previous, OperationFields fields) async {
  return await _publish(OperationAction.Update, schemaId, fields, previous);
}

/// Generates and publishes a DELETE operation on the p2panda node.
Future<DocumentViewId> delete(
    SchemaId schemaId, DocumentViewId previous) async {
  return await _publish(OperationAction.Delete, schemaId, null, previous);
}

/// Internal method to publish a p2panda operation and entry on the node.
///
/// This method automatically retreives the required entry arguments from
/// the node, encodes and signs all data correctly and sends it off via
/// GraphQL.
Future<DocumentViewId> _publish(OperationAction action, SchemaId schemaId,
    OperationFields? fields, DocumentViewId? previous) async {
  // Create and encode p2panda operation
  final encodedOperation = await p2panda.encodeOperation(
      action: action, schemaId: schemaId, fields: fields, previous: previous);

  // Get arguments to create p2panda entry from node
  final publicKey = await publicKeyHex;
  final nextArgs = await queries.nextArgs(publicKey, previous);

  // Create and sign p2panda entry with key pair and received arguments
  final encodedEntry = await p2panda.signAndEncodeEntry(
      logId: nextArgs.logId.toString(),
      seqNum: nextArgs.seqNum.toString(),
      backlinkHash: nextArgs.backlink,
      skiplinkHash: nextArgs.skiplink,
      payload: encodedOperation,
      keyPair: await keyPair);

  // ... finally publish entry and operation
  final result = await queries.publish(
      hex.encode(encodedEntry), hex.encode(encodedOperation));

  // Return last document view id
  return result.backlink!;
}
