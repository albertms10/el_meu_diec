import 'package:el_meu_diec/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(const SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookmarkCollection({})),
        ChangeNotifierProvider(create: (context) => WordCache({})),
      ],
      // Run the app and pass in the SettingsController. The app listens to the
      // SettingsController for changes, then passes it further down to the
      // SettingsView.
      child: MyApp(settingsController: settingsController),
    ),
  );
}
