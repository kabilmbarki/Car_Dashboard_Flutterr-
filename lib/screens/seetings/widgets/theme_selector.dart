import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/settings_provider.dart';
import '/theme/app_colors.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final colors = AppColors.of(context); // Accès aux couleurs dynamiques

    return SwitchListTile(
      title: Text(
        'Mode sombre',
        style: TextStyle(color: colors.textPrimary),
      ),
      value: settingsProvider.isDarkMode,
      onChanged: (value) => settingsProvider.isDarkMode = value,
      activeColor: colors.primary,
      inactiveThumbColor: colors.secondary.withOpacity(0.7),
      activeTrackColor: colors.surface,
      inactiveTrackColor: colors.surface.withOpacity(0.5),
    );
  }
}
