import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';
import '../../../theme/app_theme.dart';

class LanguageSection extends StatelessWidget {
  static const _languages = ['Français', 'Anglais', 'Espagnol', 'Arabe'];

  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, _) {
        final theme = Theme.of(context);
        final colors = theme.colorScheme;

        return Stack(
          children: [
            _buildLanguageSelector(provider, theme),
            if (provider.isDropdownOpen)
              _buildLanguageDropdown(provider, theme),
          ],
        );
      },
    );
  }

  Widget _buildLanguageSelector(SettingsProvider provider, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Text(
            "Langue",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => provider.toggleLanguageDropdown(),
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.selectedLanguage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: provider.isDropdownOpen ? 0.5 : 0,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(SettingsProvider provider, ThemeData theme) {
    return Positioned(
      right: 16,
      top: 60,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                ..._languages.map((language) => InkWell(
                      onTap: () {
                        provider.selectedLanguage = language;

                        provider.toggleLanguageDropdown();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Text(language),
                            if (provider.selectedLanguage == language)
                              const Icon(Icons.check, size: 18),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
