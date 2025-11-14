import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'providers/calculator_provider.dart';
import 'screens/compact_calculator_screen.dart';

void main() {
  runApp(const PizzaGenieApp());
}

class PizzaGenieApp extends StatelessWidget {
  const PizzaGenieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculatorProvider()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: ThemeMode.system, // Will be controlled by ThemeProvider later
        home: const CompactCalculatorScreen(),
        routes: _routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  /// Light theme configuration
  static ThemeData get _lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF8B4513), // Brown color for pizza theme
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: AppConstants.defaultElevation,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: 12,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get _darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF8B4513), // Same brown color for consistency
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: AppConstants.defaultElevation,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: 12,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
      ),
    );
  }

  /// App routes configuration
  static Map<String, WidgetBuilder> get _routes {
    return {
      '/settings': (context) => const SettingsScreen(),
      '/about': (context) => const AboutScreen(),
      '/privacy': (context) => const PrivacyScreen(),
    };
  }
}

/// Temporary placeholder screens - these will be implemented in user story phases
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_pizza,
              size: 100,
              color: Color(0xFF8B4513),
            ),
            SizedBox(height: 24),
            Text(
              'Pizza Genie',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Dough Calculator Coming Soon!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings screen - Theme controls coming soon!'),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Text('About screen coming soon!'),
      ),
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Center(
        child: Text('Privacy policy coming soon!'),
      ),
    );
  }
}