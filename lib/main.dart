import 'package:el_meu_diec/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/el_meu_diec_app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(const SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get('DATABASE_URL'),
    anonKey: dotenv.get('DATABASE_ANON_KEY'),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookmarkCollections.fromNames(const [
            'Curioses 🤭',
            'Inspiradores 🙌',
            'Preferides ✨',
          ]),
        ),
        ChangeNotifierProvider(create: (context) => WordCache({})),
      ],
      // Run the app and pass in the SettingsController. The app listens to the
      // SettingsController for changes, then passes it further down to the
      // SettingsView.
      child: ElMeuDIECApp(settingsController: settingsController),
    ),
  );
}
