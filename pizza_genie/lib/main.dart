import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';
import 'providers/calculator_provider.dart';
import 'screens/splash_screen.dart';
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
        home: const SplashScreen(),
        routes: _routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  /// Light theme configuration with Italian design
  static ThemeData get _lightTheme {
    // Italian flag colors - green as primary for sophistication
    const italianRed = Color(0xFFC8102E);
    const italianGreen = Color(0xFF009246);
    const warmWhite = Color(0xFFFFFDF8);
    const creamyWhite = Color(0xFFF8F6F0);
    
    final colorScheme = ColorScheme.light(
      primary: italianGreen,
      secondary: italianRed,
      surface: warmWhite,
      surfaceVariant: creamyWhite,
      primaryContainer: italianGreen.withOpacity(0.1),
      secondaryContainer: italianRed.withOpacity(0.1),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFF2C1810),
      onSurfaceVariant: const Color(0xFF5D4037),
      outline: const Color(0xFFBCAAA4),
      shadow: Colors.black26,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Premium typography with Italian elegance
      textTheme: GoogleFonts.interTextTheme().copyWith(
        // Headers use elegant serif for sophistication
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineSmall: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        
        // Body text uses clean Inter for readability
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.2,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
        ),
        
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
        
        // Labels and UI elements
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
          letterSpacing: 0.1,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 2,
          shadowColor: colorScheme.shadow,
        ),
      ),
      
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(16),
        labelStyle: GoogleFonts.inter(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// Dark theme configuration with Italian design
  static ThemeData get _darkTheme {
    // Italian flag colors adapted for dark theme - green primary
    const italianRedDark = Color(0xFFE53E3E);
    const italianGreenDark = Color(0xFF38A169);
    const darkSurface = Color(0xFF1A1A1A);
    const darkSurfaceVariant = Color(0xFF2D2D2D);
    
    final colorScheme = ColorScheme.dark(
      primary: italianGreenDark,
      secondary: italianRedDark,
      surface: darkSurface,
      surfaceVariant: darkSurfaceVariant,
      primaryContainer: italianGreenDark.withOpacity(0.2),
      secondaryContainer: italianRedDark.withOpacity(0.2),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFFE5E5E5),
      onSurfaceVariant: const Color(0xFFB3B3B3),
      outline: const Color(0xFF616161),
      shadow: Colors.black54,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Same typography system with dark theme colors
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineSmall: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.2,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
          letterSpacing: 0.1,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 2,
          shadowColor: colorScheme.shadow,
        ),
      ),
      
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(16),
        labelStyle: GoogleFonts.inter(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// App routes configuration
  static Map<String, WidgetBuilder> get _routes {
    return {
      '/calculator': (context) => const CompactCalculatorScreen(),
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

  Future<void> _launchCoffeeUrl(BuildContext context) async {
    final Uri url = Uri.parse('https://buymeacoffee.com/clevermonkey');
    try {
      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        throw Exception('Failed to launch URL');
      }
    } catch (e) {
      debugPrint('Could not launch $url: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open browser. Please visit buymeacoffee.com/clevermonkey'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Column(
        children: [
          // Content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/clevermonkey.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // App title
                  Text(
                    'Clevermonkey Pizza Genie',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description
                  Text(
                    'A smart dough calculator for home pizza chefs, helping you create perfect pizza dough with precise measurements and professional techniques.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Tagline
                  Text(
                    'Shared with you by a clever monkey',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Version
                  Text(
                    'Version 1.0.0',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Buy me a coffee button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: _buildCoffeeButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeButton(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchCoffeeUrl(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_cafe,
                  size: 24,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  'Buy me a coffee',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Privacy policy content
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clevermonkey Pizza Genie\nPrivacy Policy',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                      context,
                      'Information We Collect',
                      'Our Clevermonkey Pizza Genie app is designed to respect your privacy. We collect minimal information:\n\n'
                          '• App Preferences: We store your measurement system preferences (metric/imperial) and theme choices locally on your device\n'
                          '• No Personal Data: We do not collect names, email addresses, or personal information\n'
                          '• No Recipe History: Your pizza recipes and calculations are not stored or transmitted anywhere'),
                  _buildSection(
                      context,
                      'How We Use Information',
                      '• App Settings: Used solely to remember your preferred measurement units and app appearance\n'
                      '• Local Storage Only: All data stays on your device and is never transmitted to external servers'),
                  _buildSection(
                      context,
                      'Information We Don\'t Collect',
                      '• Personal identification information\n'
                          '• Location data\n'
                          '• Contact information\n'
                          '• Pizza recipe calculations or history\n'
                          '• Device identifiers\n'
                          '• Analytics or usage data'),
                  _buildSection(
                      context,
                      'Third-Party Services',
                      '• No Third-Party Analytics: We do not use Google Analytics or similar services\n'
                          '• No Advertising Networks: We do not display ads or use ad networks\n'
                          '• No External Data Sharing: Your pizza recipes and preferences never leave your device'),
                  _buildSection(
                      context,
                      'Data Security',
                      'Since we collect minimal data and store everything locally on your device:\n'
                          '• No data is transmitted over the internet\n'
                          '• No servers store your information\n'
                          '• Your privacy is protected by design'),
                  _buildSection(context, 'Children\'s Privacy',
                      'Our app is suitable for all ages and does not collect personal information from anyone, including children under 13.'),
                  _buildSection(context, 'Contact Us',
                      'If you have questions about this privacy policy, please contact us through the app store.'),
                  const SizedBox(height: 20),
                  Text(
                    'This Clevermonkey Pizza Genie app is created for home pizza enthusiasts and culinary education.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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