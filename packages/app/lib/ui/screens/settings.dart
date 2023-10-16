// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:app/app.dart';
import 'package:app/ui/widgets/simple_card.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:app/ui/widgets/scaffold.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo? _deviceData;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    final deviceData = await deviceInfoPlugin.androidInfo;

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final t = AppLocalizations.of(context)!;

    return MeliScaffold(
        title: t.settings,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: Column(children: [
                SimpleCard(
                  title: t.settingsLanguages,
                  child: DropdownMenu<Locale>(
                    initialSelection: locale,
                    onSelected: (Locale? value) {
                      // This is called when the user selects an item.
                      final app =
                          context.findAncestorStateOfType<MeliAppState>()!;
                      app.changeLocale(value!);
                    },
                    dropdownMenuEntries: [
                      DropdownMenuEntry<Locale>(
                          value: Locale('en'), label: t.settingsEnglish),
                      DropdownMenuEntry<Locale>(
                          value: Locale('pt'), label: t.settingsPortuguese)
                    ],
                  ),
                ),
                if (_deviceData != null)
                  SimpleCard(
                    title: t.settingsSystemInformation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Device: ${_deviceData!.device}'),
                        Text(
                            'Android SDK Version: ${_deviceData!.version.sdkInt}'),
                        Text(
                            'Android Build Version: ${_deviceData!.version.release}'),
                      ],
                    ),
                  ),
              ])),
        ));
  }
}
