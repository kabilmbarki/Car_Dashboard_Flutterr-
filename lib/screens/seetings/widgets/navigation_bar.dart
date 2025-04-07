import 'package:flutter/material.dart';

// Assure-toi d'importer tes pages
//import 'home_page.dart'; // Page d'accueil
import '../../map_page.dart'; // Page de carte
import '../../settings_page.dart'; // Page de paramètres
import '../../controller_page.dart';
import '../../home_page.dart';

class CustomNavigationBar extends StatelessWidget {
  final String? selectedIconId;
  final Function(String) onIconPressed;

  const CustomNavigationBar({
    super.key,
    required this.selectedIconId,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Image de fond
        Positioned(
          left: 270,
          top: 700,
          child: Image.asset(
            'assets/images/nav_bar.png',
            width: 731,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.red.withOpacity(0.5),
              width: 800,
              height: 70,
              child: const Center(
                child: Text(
                  'Image manquante',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        // Icônes positionnées au-dessus de l’image
        Positioned(
          left: 485, // marge horizontale
          top: 650, // position verticale
          child: Row(
            children: [
              _buildNavItem(Icons.home_rounded, 'home', context),
              const SizedBox(width: 30),
              _buildNavItem(Icons.map_rounded, 'map', context),
              const SizedBox(width: 30),
              _buildNavItem(Icons.sports_esports_rounded, 'game', context),
              const SizedBox(width: 30),
              _buildNavItem(Icons.settings_rounded, 'settings', context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String id, BuildContext context) {
    final isSelected = id == selectedIconId;
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? colors.primary : colors.onSurface.withOpacity(0.6),
        size: 40,
      ),
      onPressed: () {
        onIconPressed(id);
        // Naviguer vers la page appropriée en fonction de l'ID
        switch (id) {
          case 'home':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            break;
          case 'map':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            );
            break;
          case 'game':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ControllerPage()),
            );
            break;
          case 'settings':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
            break;
        }
      },
    );
  }
}
