import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../theme/app_colors.dart';
import 'seetings/widgets/settings_item.dart';
import 'seetings/widgets/navigation_bar.dart'; // Assurez-vous que ce chemin est correct
import 'sections/language_section.dart';
import 'sections/battery_section.dart';
import 'sections/sound_section.dart';
import 'sections/Vitesse_section.dart';
import 'sections/language_section.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? _selectedItemIndex; // Track the selected item index

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final colors =
        AppColors.of(context); // Utilisation de vos couleurs personnalisées

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Arrière-plan
            _buildBackground(colors),

            // Contenu principal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // En-tête
                  _buildHeader(provider, colors),

                  // Contenu des paramètres
                  Expanded(
                    child: _buildContent(provider, colors),
                  ),
                ],
              ),
            ),

            // Barre de navigation personnalisée
            CustomNavigationBar(
              selectedIconId: provider.selectedIconId,
              onIconPressed: (id) => provider.onIconPressed(id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(ThemeColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.background,
      ),
    );
  }

  Widget _buildHeader(SettingsProvider provider, ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Paramètres',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContent(SettingsProvider provider, ThemeColors colors) {
    return Stack(
      children: [
        // Liste des paramètres
        Positioned(
          left: 20, // Position X
          top: 20, // Position Y
          width: 675,
          height: 500,
          child: _buildSettingsList(provider, colors),
        ),

        // Panneau de contenu
        Positioned(
          top: 20, // Position Y
          left: 750, // Position X
          right: 20,
          height: 500,

          child: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildSelectedContent(provider),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList(SettingsProvider provider, ThemeColors colors) {
    return Container(
      width: 665,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: provider.settingsItems.length,
        itemBuilder: (ctx, index) => SettingsItem(
          title: provider.settingsItems[index]['title'] as String,
          isSelected: provider.selectedIndex == index,
          onTap: () {
            provider.updateSelection(index);
            setState(() {
              _selectedItemIndex = index; // Update selected item index
            });
          },
        ),
      ),
    );
  }

  Widget _buildSelectedContent(SettingsProvider provider) {
    final sections = [
      const SoundSection(),
      const BatterySection(),
      const LanguageDisplaySection(),
      const VitesseSection(),
    ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: sections[provider.selectedIndex],
    );
  }
}
