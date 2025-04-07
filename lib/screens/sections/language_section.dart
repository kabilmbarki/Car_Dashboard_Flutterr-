import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';
import '/theme/app_colors.dart';

class LanguageDisplaySection extends StatefulWidget {
  const LanguageDisplaySection({super.key});

  @override
  State<LanguageDisplaySection> createState() => _LanguageDisplaySectionState();
}

class _LanguageDisplaySectionState extends State<LanguageDisplaySection> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final colors = AppColors.of(context);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // LANGAGE Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    "Langage",
                    style: TextStyle(
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => setState(() {
                      _isDropdownOpen = !_isDropdownOpen;
                    }),
                    child: Container(
                      height: 40,
                      width: 250,
                      margin: const EdgeInsets.only(left: 100),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: colors.secondary),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.selectedLanguage,
                            style: TextStyle(color: colors.primary),
                          ),
                          Icon(Icons.arrow_drop_down, color: colors.primary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ÉCRAN Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Écran",
                  style: TextStyle(fontSize: 16, color: colors.textPrimary)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _themeRadio("Clair", false, provider.isDarkMode, colors),
                const SizedBox(width: 50),
                _themeRadio("Sombre", true, provider.isDarkMode, colors),
              ],
            ),

            const SizedBox(height: 20),

            // LUMINOSITÉ Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Luminosité",
                  style: TextStyle(color: colors.textPrimary)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: colors.primary,
                  inactiveTrackColor: colors.primary.withOpacity(0.3),
                  thumbColor: colors.textPrimary,
                  overlayColor: colors.primary.withOpacity(0.2),
                  valueIndicatorColor: colors.background,
                  valueIndicatorTextStyle: TextStyle(color: colors.textPrimary),
                ),
                child: Slider(
                  value: provider.brightness,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: "${provider.brightness.round()}%",
                  onChanged: (val) {
                    setState(() => provider.brightness = val);
                    provider.notifyListeners();
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            // CONFORT VISUEL Section
            SwitchListTile(
              title: Text("Confort visuel",
                  style: TextStyle(color: colors.textPrimary)),
              value: provider.visualComfort,
              onChanged: (val) {
                setState(() => provider.visualComfort = val);
                provider.notifyListeners();
              },
              activeColor: colors.surface,
              inactiveThumbColor: colors.secondary,
              activeTrackColor: colors.primary,
              inactiveTrackColor: colors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ],
        ),

        // DROPDOWN MENU LANGUE with fade animation
        if (_isDropdownOpen)
          AnimatedPositioned(
            left: 198,
            top: 51,
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              opacity: _isDropdownOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(10)),
                  border: Border.all(color: colors.secondary),
                  boxShadow: [
                    BoxShadow(
                        color: colors.primary.withOpacity(0.1), blurRadius: 4)
                  ],
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: ["Français", "Anglais"].map((lang) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          provider.selectedLanguage = lang;
                          _isDropdownOpen = false;
                        });
                        provider.notifyListeners();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(lang,
                            style: TextStyle(color: colors.textPrimary)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _themeRadio(
      String label, bool value, bool groupValue, ThemeColors colors) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: colors.textPrimary)),
        Radio<bool>(
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            setState(() => Provider.of<SettingsProvider>(context, listen: false)
                .isDarkMode = val!);
            Provider.of<SettingsProvider>(context, listen: false)
                .notifyListeners();
          },
          activeColor: colors.primary,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
