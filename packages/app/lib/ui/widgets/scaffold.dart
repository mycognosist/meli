// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';

import 'package:app/ui/colors.dart';
import 'package:app/ui/widgets/fab.dart';

class MeliScaffold extends StatefulWidget {
  final String? title;
  final Widget? body;
  final Color backgroundColor;
  final List<MeliFloatingActionButton> floatingActionButtons;
  final MainAxisAlignment fabAlignment;

  MeliScaffold(
      {super.key,
      this.body,
      this.title,
      this.floatingActionButtons = const [],
      this.fabAlignment = MainAxisAlignment.spaceBetween,
      this.backgroundColor = MeliColors.flurry});

  @override
  State<MeliScaffold> createState() => _MeliScaffoldState();
}

class _MeliScaffoldState extends State<MeliScaffold> {
  AppBar? _appBar() {
    if (widget.title != null) {
      return AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          SizedBox(width: 7.0),
          Text(widget.title!),
          SizedBox(width: 35.0),
        ]),
      );
    }

    return null;
  }

  Widget? _floatingActionButtons() {
    if (widget.floatingActionButtons.isNotEmpty) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Row(
            mainAxisAlignment: widget.fabAlignment,
            children: widget.floatingActionButtons,
          ));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: _appBar(),
      body: widget.body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButtons(),
    );
  }
}
