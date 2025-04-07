import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => _buildTheme(LightColors());
  static ThemeData get dark => _buildTheme(DarkColors());

  static ThemeData _buildTheme(ThemeColors colors) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: colors.background.computeLuminance() > 0.5
            ? Brightness.light
            : Brightness.dark,
        primary: colors.primary,
        onPrimary: colors.textPrimary,
        secondary: colors.secondary,
        onSecondary: colors.textPrimary,
        error: colors.error,
        onError: colors.onError,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        background: colors.background,
        onBackground: colors.textPrimary,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          color: colors.textPrimary,
        ),
      ),
      // You can later access colors.green and colors.orange via AppColors.of(context)
    );
  }
}
