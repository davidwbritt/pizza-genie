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
      '/pizza-history': (context) => const PizzaHistoryScreen(),
      '/pizza-styles': (context) => const PizzaStylesScreen(),
      '/up-your-game': (context) => const UpYourGameScreen(),
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
              'Clevermonkey\nPizza Genie',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
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

class PizzaHistoryScreen extends StatelessWidget {
  const PizzaHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza History'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_edu,
              size: 64,
              color: Color(0xFF8B4513),
            ),
            SizedBox(height: 16),
            Text(
              'Pizza History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming soon! The fascinating story of pizza.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PizzaStylesScreen extends StatelessWidget {
  const PizzaStylesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Styles'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: 64,
              color: Color(0xFF8B4513),
            ),
            SizedBox(height: 16),
            Text(
              'Pizza Styles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming soon! Regional pizza varieties guide.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpYourGameScreen extends StatelessWidget {
  const UpYourGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Up Your Game'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Pro Pizza Tips',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            _buildTipSection(
              context,
              icon: Icons.grass,
              title: 'Flour: The Foundation',
              content: 'Use "00" flour (doppio zero) for authentic Neapolitan pizza. This finely ground Italian flour creates a silky dough that\'s easier to stretch and produces a tender, chewy crust. Regular bread flour works too, but 00 flour is the secret to professional results.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.cookie,
              title: 'Sugar: The Browning Secret',
              content: 'Add 1-2% sugar by flour weight for beautiful browning. Sugar feeds the yeast and caramelizes during baking, creating that golden, spotted "leoparding" on authentic pizza crusts. Honey or malt extract work even better for complex flavors.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.access_time,
              title: 'Cold Fermentation',
              content: 'Let your dough slow-ferment in the fridge for 24-72 hours. This develops complex flavors and makes the dough more digestible. The longer fermentation breaks down proteins and creates the signature tangy taste of great pizza.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.thermostat,
              title: 'Temperature Matters',
              content: 'Use room temperature water (around 70°F) to control yeast activity. For faster rises, use slightly warmer water. For overnight dough, use cooler water. Always check your flour temperature too - cold flour slows fermentation.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.scale,
              title: 'Hydration Control',
              content: 'Higher hydration (70-80%) creates an open, airy crumb but requires practice to handle. Start with 60-65% hydration and work your way up as your technique improves. Wetter doughs need gentle handling and good flour.',
            ),
            
            _buildTipSection(
              context,
              icon: Icons.local_fire_department,
              title: 'Heat is Everything',
              content: 'Pizza needs extreme heat - 800°F+ for Neapolitan style. Home ovens max out around 500°F, so use a pizza stone or steel preheated for at least 45 minutes. Consider a pizza oven attachment for your grill.',
            ),
            
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Master\'s Secret',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The best pizza makers taste their dough. It should be slightly sweet, pleasantly tangy (if fermented), and have a clean, yeasty aroma. Trust your senses - they\'ll tell you when your dough is ready.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipSection(BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}