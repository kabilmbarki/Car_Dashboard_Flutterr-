import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  // États privés
  int _selectedIndex = 0;
  String? _blurredIcon;
  double _volume = 0.5;
  bool _notificationsEnabled = true;
  double _brightness = 50.0;
  bool _isDropdownOpen = false;
  String _selectedLanguage = "Français";
  bool _isDarkMode = false;
  bool _visualComfort = false;
  int _speedLimit = 80;
  int _batteryLevel = 50;
  bool _showBatteryInNavBar = false;
  bool _lowBatteryAlert = false;
  String? _selectedIconId;

  // Getters publics
  int get selectedIndex => _selectedIndex;
  String? get blurredIcon => _blurredIcon;
  double get volume => _volume;
  bool get notificationsEnabled => _notificationsEnabled;
  double get brightness => _brightness;
  bool get isDropdownOpen => _isDropdownOpen;
  String get selectedLanguage => _selectedLanguage;
  bool get isDarkMode => _isDarkMode;
  bool get visualComfort => _visualComfort;
  int get speedLimit => _speedLimit;
  int get batteryLevel => _batteryLevel;
  bool get showBatteryInNavBar => _showBatteryInNavBar;
  bool get lowBatteryAlert => _lowBatteryAlert;
  String? get selectedIconId => _selectedIconId;

  // Setters avec validation et notification
  set selectedIndex(int value) {
    _selectedIndex = value.clamp(0, settingsItems.length - 1);
    notifyListeners();
  }

  set blurredIcon(String? value) {
    _blurredIcon = value;
    notifyListeners();
  }

  set volume(double value) {
    _volume = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  set notificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  set brightness(double value) {
    _brightness = value.clamp(0.0, 100.0);
    notifyListeners();
  }

  set isDropdownOpen(bool value) {
    _isDropdownOpen = value;
    notifyListeners();
  }

  set selectedLanguage(String value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  set visualComfort(bool value) {
    _visualComfort = value;
    notifyListeners();
  }

  set speedLimit(int value) {
    _speedLimit = value.clamp(0, 200);
    notifyListeners();
  }

  set batteryLevel(int value) {
    _batteryLevel = value.clamp(0, 100);
    notifyListeners();
  }

  set showBatteryInNavBar(bool value) {
    _showBatteryInNavBar = value;
    notifyListeners();
  }

  set lowBatteryAlert(bool value) {
    _lowBatteryAlert = value;
    notifyListeners();
  }

  set selectedIconId(String? value) {
    _selectedIconId = value;
    notifyListeners();
  }

  // Menu de configuration
  final List<Map<String, dynamic>> settingsItems = const [
    {'title': 'Son et Notification', 'route': '/son', 'top': 173.0},
    {'title': 'Batterie', 'route': '/batterie', 'top': 233.0},
    {'title': 'Langage et Affichage', 'route': '/language', 'top': 293.0},
    {'title': 'Vitesse Maximale Autorisée', 'route': '/vitesse', 'top': 353.0},
    {
      'title': 'Surveillance des angles morts',
      'route': '/angles',
      'top': 413.0
    },
    {
      'title': 'Commandes vocales & assistant IA',
      'route': '/commande',
      'top': 473.0
    },
    {
      'title': 'Reconnaissance des panneaux',
      'route': '/panneaux',
      'top': 533.0
    },
  ];

  // Méthodes utiles
  void toggleLanguageDropdown() {
    isDropdownOpen = !isDropdownOpen;
  }

  void onIconPressed(String id) {
    selectedIconId = id;
  }

  void updateSelection(int index) {
    selectedIndex = index;
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
  }
}
