import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/settings_provider.dart';

abstract interface class ThemeColors {
  Color get background;
  Color get surface;
  Color get primary;
  Color get secondary;
  Color get textPrimary;
  Color get error;
  Color get onError;
  Color get green;
  Color get orange;
}

class LightColors implements ThemeColors {
  const LightColors();

  @override
  Color get onError => const Color(0xFFFFFFFF);
  @override
  Color get background => const Color(0xFFDDE6ED);
  @override
  Color get surface => const Color(0xFFE4EBF1);
  @override
  Color get primary => const Color(0xFF32424F);
  @override
  Color get secondary => const Color(0xFF526D82);
  @override
  Color get textPrimary => const Color(0xFF27374D);
  @override
  Color get error => const Color(0xFFD32F2F);
  @override
  Color get green => const Color(0xFF0EC253);
  @override
  Color get orange => const Color(0xFFFF9800);
}

class DarkColors implements ThemeColors {
  const DarkColors();

  @override
  Color get onError => const Color(0xFF000000);
  @override
  Color get background => const Color(0xFF27374D);
  @override
  Color get surface => const Color(0xFF32424F);
  @override
  Color get primary => const Color(0xFFDDE6ED);
  @override
  Color get secondary => const Color(0xFF526D82);
  @override
  Color get textPrimary => const Color(0xFFDDE6ED);
  @override
  Color get error => const Color(0xFFD32F2F);
  @override
  Color get green => const Color(0xFF0EC253);
  @override
  Color get orange => const Color(0xFFFF9800);
}

class AppColors {
  static const ThemeColors light = LightColors();
  static const ThemeColors dark = DarkColors();

  static ThemeColors of(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context, listen: true);
    return provider.isDarkMode ? dark : light;
  }
}
