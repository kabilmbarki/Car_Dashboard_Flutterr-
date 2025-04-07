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
        // Titre pour activer les commandes vocales
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0,
              top: 12.0), // Customize x (left) and y (top) positioning
          child: Text(
            "Notifications", // Titre de la section
            style: TextStyle(
              color:
                  colors.textPrimary, // Couleur du texte en fonction du thème
            ),
          ),
        ),
        const SizedBox(height: 10), // Espacement après le titre

        // Slider pour la luminosité
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor:
                colors.primary, // Couleur personnalisée pour la piste active
            inactiveTrackColor:
                colors.primary, // Couleur personnalisée pour la piste inactive
            thumbColor: colors.textPrimary, // Couleur du curseur
            overlayColor:
                colors.primary.withOpacity(0.2), // Couleur de l'overlay
            valueIndicatorColor:
                colors.background, // Couleur de l'indicateur de valeur
            valueIndicatorTextStyle: TextStyle(color: colors.textPrimary),
          ),
          child: Slider(
            value: provider.brightness, // Valeur pour ajuster la luminosité
            onChanged: (double value) {
              provider.brightness =
                  value; // Mettre à jour la valeur de la luminosité
            },
            divisions: 10,
            label:
                "${(provider.brightness).round()}%", // Afficher le pourcentage de luminosité
            min: 0,
            max: 100,
          ),
        ),

        const SizedBox(height: 20), // Espacement après le slider

        // Switch pour activer les notifications avec un ajustement de positionnement
        Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 10.0), // Customize x (left) and y (top) positioning
              child: SwitchListTile(
                title: const Text("Activer les notifications"),
                value: provider.notificationsEnabled,
                onChanged: (bool value) {
                  provider.notificationsEnabled =
                      value; // Mise à jour de l'état des notifications
                  provider
                      .notifyListeners(); // Important pour mettre à jour l'interface
                },
                activeColor: colors.surface, // Couleur de l'état actif
                inactiveThumbColor:
                    colors.secondary, // Couleur de l'état inactif
                activeTrackColor: colors.primary, // Couleur de la piste active
                inactiveTrackColor:
                    colors.surface, // Couleur de la piste inactive
              ),
            );
          },
        ),
      ],
    );
  }
}
