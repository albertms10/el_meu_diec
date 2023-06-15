import 'package:el_meu_diec/src/pages/home_page.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, child) {
        return MaterialApp(
          title: 'DIEC',
          restorationScopeId: 'el_meu_diec',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ca')],
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: settingsController.themeMode,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);

                  case HomePage.routeName:
                  default:
                    return const HomePage();
                }
              },
            );
          },
        );
      },
    );
  }
}
