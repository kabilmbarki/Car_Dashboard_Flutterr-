import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';
import '/theme/app_colors.dart';

class BlindSpotSection extends StatelessWidget {
  const BlindSpotSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context, listen: true);
    final colors = AppColors.of(context); // Accéder aux couleurs selon le thème

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Switch pour activer la surveillance des angles morts
        SwitchListTile(
          title: Text(
            "Surveillance active des angles morts",
            style: TextStyle(
                color: colors.textPrimary), // Texte en fonction du thème
          ),
          value: provider.blindSpotEnabled, // Utiliser le getter
          onChanged: (bool value) {
            provider.blindSpotEnabled = value; // Utiliser le setter
          },
          activeColor: colors.surface, // Couleur du curseur activé
          inactiveThumbColor: colors.secondary, // Couleur du curseur désactivé
          activeTrackColor: colors.primary, // Couleur de la piste activée
          inactiveTrackColor: colors.surface, // Couleur de la piste désactivée
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0), // Espacement
        ),
        const SizedBox(height: 20), // Espacement après le switch
      ],
    );
  }
}
