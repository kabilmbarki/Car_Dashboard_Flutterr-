import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';
import '/theme/app_colors.dart'; // Import custom color scheme

class BatterySection extends StatelessWidget {
  const BatterySection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final colors = AppColors.of(context); // Access custom theme colors

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.battery_charging_full, color: colors.primary),
          title: LinearProgressIndicator(
            value: provider.batteryLevel / 100,
            backgroundColor: colors.surface, // Custom surface color
            valueColor: AlwaysStoppedAnimation<Color>(
              provider.batteryLevel < 20
                  ? colors.error
                  : colors.primary, // Custom error or primary color
            ),
          ),
          subtitle: Text(
            "${provider.batteryLevel}% de charge",
            style: TextStyle(
                color:
                    colors.textPrimary.withOpacity(0.6)), // Custom text color
          ),
        ),
        _buildSwitchTile(
          title: "Alerte batterie faible",
          value: provider.lowBatteryAlert,
          onChanged: (value) {
            provider.lowBatteryAlert = value;
            if (value && provider.batteryLevel < 30) {
              _showLowBatteryAlert(context);
            }
          },
          colors: colors,
        ),
        _buildSwitchTile(
          title: "Afficher dans la barre de navigation",
          value: provider.showBatteryInNavBar,
          onChanged: (value) {
            provider.showBatteryInNavBar = value;
            _updateAppSwitcher(context, value, provider.batteryLevel);
          },
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeColors colors, // Using ThemeColors instead of ColorScheme
  }) {
    return SwitchListTile(
      title: Text(title,
          style: TextStyle(color: colors.textPrimary)), // Use custom text color
      value: value,
      onChanged: onChanged,
      activeColor: colors.surface, // Custom active color
      inactiveThumbColor:
          colors.secondary, // Custom secondary color for inactive thumb
      activeTrackColor: colors.primary, // Custom active track color
      inactiveTrackColor: colors.surface, // Custom inactive track color
    );
  }

  void _showLowBatteryAlert(BuildContext context) {
    final colors = AppColors.of(context); // Access custom theme colors

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alerte Batterie", style: TextStyle(color: colors.error)),
        content: const Text("Niveau de batterie critique !"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("OK", style: TextStyle(color: colors.primary)),
          ),
        ],
      ),
    );
  }

  void _updateAppSwitcher(BuildContext context, bool show, int level) {
    final colors = AppColors.of(context); // Access custom theme colors

    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: show ? "Batterie : $level%" : "MyApp",
        primaryColor: colors.primary.value,
      ),
    );
  }
}
