import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';
import '/theme/app_colors.dart';

class SoundSection extends StatelessWidget {
  const SoundSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context, listen: true);
    final colors =
        AppColors.of(context); // Access the colors based on the theme

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Slider for volume
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colors.primary, // Use custom primary color
            inactiveTrackColor: colors.primary, // Use custom secondary color
            thumbColor:
                colors.textPrimary, // Use textPrimary color for the thumb
            overlayColor: colors.primary
                .withOpacity(0.2), // Use surface color for overlay effect
            valueIndicatorColor:
                colors.background, // Use surface color for value indicator
            valueIndicatorTextStyle: TextStyle(color: colors.textPrimary),
          ),
          child: Slider(
            value: provider.volume,
            onChanged: (double value) {
              provider.volume = value;
            },
            divisions: 10,
            label: "${(provider.volume * 100).round()}%",
            min: 0,
            max: 1,
          ),
        ),

        // Switch for notifications
        Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            return SwitchListTile(
              title: const Text("Activer les notifications"),
              value: provider.notificationsEnabled,
              onChanged: (bool value) {
                provider.notificationsEnabled = value;
                provider.notifyListeners(); // Important to update the UI
              },
              activeColor: colors.surface, // Use surface color for active state
              inactiveThumbColor:
                  colors.secondary, // Use secondary color for inactive thumb
              activeTrackColor:
                  colors.primary, // Use surface color for active track
              inactiveTrackColor:
                  colors.surface, // Use secondary color for inactive track
            );
          },
        ),
      ],
    );
  }
}
