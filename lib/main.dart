import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'theme/app_theme.dart';
import 'screens/settings_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(builder: (context, provider, child) {
        return MaterialApp(
          title: 'Paramètres Avancés',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SettingsPage(),
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                boldText: false, // Ajout recommandé
              ),
              child: child!,
            );
          },
        );
      }),
    );
  }
}
