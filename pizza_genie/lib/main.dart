import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';
import 'providers/calculator_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/compact_calculator_screen.dart';
import 'screens/pizza_styles_screen.dart';
import 'screens/up_your_game_screen.dart';
import 'screens/about_screen.dart';
import 'screens/privacy_screen.dart';
import 'screens/pizza_history_screen.dart';
import 'theme/app_theme.dart';

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
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme, // Force light theme to prevent system overrides
        themeMode: ThemeMode.light, // Always use our custom Italian theme
        home: const SplashScreen(),
        routes: _routes,
        debugShowCheckedModeBanner: false,
        // Disable Material You dynamic theming
        builder: (context, child) {
          return Theme(
            data: AppTheme.lightTheme,
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }


  /// App routes configuration
  static Map<String, WidgetBuilder> get _routes {
    return {
      '/calculator': (context) => const CompactCalculatorScreen(),
      '/about': (context) => const AboutScreen(),
      '/privacy': (context) => const PrivacyScreen(),
      '/pizza-history': (context) => const PizzaHistoryScreen(),
      '/pizza-styles': (context) => const PizzaStylesScreen(),
      '/up-your-game': (context) => const UpYourGameScreen(),
    };
  }
}





