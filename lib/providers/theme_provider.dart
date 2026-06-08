import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool _isDarkMode = false;
  bool _isInitialized = false;

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;

  ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2D6A4F),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: 'Georgia',
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2D6A4F),
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF2D6A4F),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D6A4F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF2D6A4F),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2D6A4F),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: 'Georgia',
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1a3a2f),
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF2D6A4F),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D6A4F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF7dcd9c),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        color: const Color(0xFF1e1e1e),
      ),
    );
  }

  // Initialize theme provider
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing theme provider: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Toggle theme
  Future<void> toggleTheme() async {
    try {
      _isDarkMode = !_isDarkMode;
      await _prefs.setBool('isDarkMode', _isDarkMode);
      notifyListeners();
    } catch (e) {
      print('Error toggling theme: $e');
    }
  }

  // Set light mode
  Future<void> setLightMode() async {
    try {
      if (_isDarkMode) {
        _isDarkMode = false;
        await _prefs.setBool('isDarkMode', false);
        notifyListeners();
      }
    } catch (e) {
      print('Error setting light mode: $e');
    }
  }

  // Set dark mode
  Future<void> setDarkMode() async {
    try {
      if (!_isDarkMode) {
        _isDarkMode = true;
        await _prefs.setBool('isDarkMode', true);
        notifyListeners();
      }
    } catch (e) {
      print('Error setting dark mode: $e');
    }
  }

  // Get current theme data
  ThemeData getCurrentTheme() {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  // Get primary color based on theme
  Color getPrimaryColor() {
    return const Color(0xFF2D6A4F);
  }

  // Get secondary color based on theme
  Color getSecondaryColor() {
    return _isDarkMode
        ? const Color(0xFF7dcd9c)
        : const Color(0xFF40916C);
  }

  // Get background color based on theme
  Color getBackgroundColor() {
    return _isDarkMode ? const Color(0xFF121212) : Colors.white;
  }

  // Get surface color based on theme
  Color getSurfaceColor() {
    return _isDarkMode ? const Color(0xFF1e1e1e) : const Color(0xFFF5F5F5);
  }

  // Get text color based on theme
  Color getTextColor() {
    return _isDarkMode ? Colors.white : Colors.black87;
  }

  // Get border color based on theme
  Color getBorderColor() {
    return _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
  }

  // Reset theme to light mode
  Future<void> resetTheme() async {
    try {
      _isDarkMode = false;
      await _prefs.setBool('isDarkMode', false);
      notifyListeners();
    } catch (e) {
      print('Error resetting theme: $e');
    }
  }
}
