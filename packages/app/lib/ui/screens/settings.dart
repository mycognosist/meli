// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';

import 'package:app/ui/widgets/expandable_card.dart';
import 'package:app/ui/widgets/scaffold.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MeliScaffold(
        title: 'Settings',
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: SettingsList()),
        ));
  }
}

class SettingsList extends StatelessWidget {
  final List<Widget> menuListItems = [
    ExpandableCard(
      title: 'Language',
      children: [Text('portuguese'), Text('english')],
    ),
    ExpandableCard(
      title: 'Advanced Settings',
      children: [Text('Don\'t click here'), Text('Don\'t click here either!')],
    ),
    ExpandableCard(
      title: 'Sytem Information',
      children: [Text('...')],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: menuListItems);
  }
}
