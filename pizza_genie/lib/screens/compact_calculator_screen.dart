import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';
import '../widgets/compact_input_panel.dart';
import '../widgets/compact_results_panel.dart';

/// Compact calculator screen with horizontal swipe navigation
///
/// This screen provides a mobile-first, swipe-based interface for pizza
/// dough calculation with compact controls and horizontal navigation.
class CompactCalculatorScreen extends StatefulWidget {
  const CompactCalculatorScreen({super.key});

  @override
  State<CompactCalculatorScreen> createState() => _CompactCalculatorScreenState();
}

class _CompactCalculatorScreenState extends State<CompactCalculatorScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Page indicator and navigation
              _buildPageIndicator(provider),
              
              // Main content area with horizontal swipe
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    // Page 1: Input Controls
                    const CompactInputPanel(),
                    
                    // Page 2: Results (only if calculated)
                    if (provider.showResults)
                      const CompactResultsPanel()
                    else
                      _buildCalculatePrompt(provider),
                  ],
                ),
              ),
              
              // Bottom action bar
              _buildBottomActionBar(provider),
            ],
          );
        },
      ),
    );
  }

  /// Build page indicator at the top
  Widget _buildPageIndicator(CalculatorProvider provider) {
    final totalPages = provider.showResults ? 2 : 1;
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Page dots
          Row(
            children: List.generate(totalPages, (index) {
              final isActive = index == _currentPage;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive 
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          
          if (totalPages > 1) ...[
            const SizedBox(width: 16),
            Text(
              _getPageLabel(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getPageLabel() {
    switch (_currentPage) {
      case 0:
        return 'Setup';
      case 1:
        return 'Recipe';
      default:
        return '';
    }
  }

  /// Build calculate prompt when no results available
  Widget _buildCalculatePrompt(CalculatorProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              size: 48,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Swipe left to configure your pizza',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            Text(
              'Then tap Calculate to see your recipe',
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

  /// Build bottom action bar
  Widget _buildBottomActionBar(CalculatorProvider provider) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Navigation hints
            if (_currentPage == 0) ...[
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.swipe,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      provider.showResults ? 'Swipe to see recipe' : 'Configure your pizza',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Back to input button
              TextButton.icon(
                onPressed: () {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              const Spacer(),
            ],
            
            // Main action button
            if (_currentPage == 0)
              _buildCalculateButton(provider)
            else
              _buildNewRecipeButton(provider),
          ],
        ),
      ),
    );
  }

  /// Build calculate button
  Widget _buildCalculateButton(CalculatorProvider provider) {
    return ElevatedButton(
      onPressed: provider.isCalculating ? null : () async {
        final success = await provider.calculateRecipe();
        
        if (success && mounted) {
          // Auto-navigate to results
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        } else if (!success && mounted) {
          // Show error feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                provider.validationErrors.values.first,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: AppConstants.defaultPadding,
                right: AppConstants.defaultPadding,
              ),
            ),
          );
        }
      },
      child: provider.isCalculating
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Calculate'),
    );
  }

  /// Build new recipe button
  Widget _buildNewRecipeButton(CalculatorProvider provider) {
    return ElevatedButton.icon(
      onPressed: () {
        provider.resetForm();
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      icon: const Icon(Icons.refresh),
      label: const Text('New Recipe'),
    );
  }
}

/// Quick access floating action for common actions
class QuickActionsFAB extends StatelessWidget {
  const QuickActionsFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            _showQuickPresets(context, provider);
          },
          icon: const Icon(Icons.flash_on),
          label: const Text('Quick'),
        );
      },
    );
  }

  void _showQuickPresets(BuildContext context, CalculatorProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Presets',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildPresetTile(
                    context,
                    'NY Style',
                    '12" • Medium • 24h',
                    () => _applyPreset(context, provider, 12.0, 2, 24, 1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPresetTile(
                    context,
                    'Neapolitan',
                    '12" • Traditional • 24h',
                    () => _applyPreset(context, provider, 12.0, 3, 24, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _buildPresetTile(
                    context,
                    'Quick',
                    '14" • Medium • 4h',
                    () => _applyPreset(context, provider, 14.0, 2, 4, 1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPresetTile(
                    context,
                    'Party',
                    '16" • Thick • 8h',
                    () => _applyPreset(context, provider, 16.0, 3, 8, 2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetTile(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          onTap();
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _applyPreset(
    BuildContext context,
    CalculatorProvider provider,
    double diameter,
    int thickness,
    int provingTime,
    int numberOfPizzas,
  ) {
    provider.clearResults();
    provider.updateDiameter(diameter.toString());
    provider.updateThickness(thickness.toString());
    provider.updateProvingTime(provingTime.toString());
    provider.updateNumberOfPizzas(numberOfPizzas.toString());
  }
}