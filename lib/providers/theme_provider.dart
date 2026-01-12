import 'package:flutter/material.dart';
import '../boxes.dart';
import '../model/settings.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    final settingsBox = Boxes.getSettingsBox();
    if (settingsBox.isNotEmpty) {
      _isDarkMode = settingsBox.getAt(0)!.isDarkMode;
    } else {
      // Erstelle Standard-Einstellungen wenn keine vorhanden
      final settings = Settings(isDarkMode: false);
      settingsBox.add(settings);
      _isDarkMode = false;
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme();
    notifyListeners();
  }

  void _saveTheme() {
    final settingsBox = Boxes.getSettingsBox();
    if (settingsBox.isNotEmpty) {
      final settings = settingsBox.getAt(0)!;
      settings.isDarkMode = _isDarkMode;
      settings.save();
    } else {
      final settings = Settings(isDarkMode: _isDarkMode);
      settingsBox.add(settings);
    }
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 2,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: const CardThemeData(
        color: Color(0xFF1E1E1E),
        elevation: 2,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
