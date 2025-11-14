import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../widgets/calculator_form.dart';
import '../widgets/ingredient_display.dart';
import '../constants/constants.dart';

/// Main calculator screen for pizza dough recipe calculation
///
/// This screen combines the calculator form and ingredient display widgets
/// to provide a complete pizza dough calculation experience.
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

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
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App introduction card
                if (!provider.showResults) _buildIntroCard(context),
                
                // Quick preset buttons
                if (!provider.showResults) ...[
                  const PresetButtons(),
                  const SizedBox(height: AppConstants.defaultPadding * 1.5),
                ],
                
                // Calculator form
                _buildFormSection(context, provider),
                
                // Results display (only shown when results are available)
                if (provider.showResults) ...[
                  const SizedBox(height: AppConstants.defaultPadding * 2),
                  _buildResultsSection(context),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  /// Build introduction card with app description
  Widget _buildIntroCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding * 2),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Icon(
              Icons.local_pizza,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            
            Text(
              'Welcome to Pizza Genie!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            Text(
              'Create perfect pizza dough recipes tailored to your size, style, and timing preferences. Just enter your pizza details below.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build calculator form section
  Widget _buildFormSection(BuildContext context, CalculatorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calculate,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  provider.showResults ? 'Recipe Parameters' : 'Pizza Calculator',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                if (provider.showResults) ...[
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      provider.clearResults();
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                  ),
                ],
              ],
            ),
            
            if (!provider.showResults) ...[
              const SizedBox(height: 8),
              Text(
                'Enter your pizza specifications to generate a custom dough recipe.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Calculator form
            const CalculatorForm(),
          ],
        ),
      ),
    );
  }

  /// Build results section
  Widget _buildResultsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.receipt_long,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Your Recipe',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        
        // Ingredient display widget
        const IngredientDisplay(),
      ],
    );
  }
}

/// Welcome screen for first-time users
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_pizza,
                size: 120,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: AppConstants.defaultPadding * 2),
              
              Text(
                'Welcome to Pizza Genie',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              
              Text(
                AppConstants.appDescription,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.defaultPadding * 3),
              
              // Features list
              _buildFeatureItem(
                context,
                Icons.straighten,
                'Multiple Pizza Sizes',
                'Support for 10", 12", 14", and 16" pizzas',
              ),
              _buildFeatureItem(
                context,
                Icons.layers,
                'Five Thickness Styles',
                'Very Thin to Sicilian - each with optimized ratios',
              ),
              _buildFeatureItem(
                context,
                Icons.schedule,
                'Flexible Proving Time',
                'From quick 1-hour to slow 48-hour fermentation',
              ),
              _buildFeatureItem(
                context,
                Icons.scale,
                'Dual Measurements',
                'Both metric and imperial for any kitchen setup',
              ),
              
              const SizedBox(height: AppConstants.defaultPadding * 3),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const CalculatorScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Start Calculating',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding),
          
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
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}