import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../constants/constants.dart';
import '../widgets/compact_input_panel.dart';
import '../widgets/cooking_steps_panel.dart';

/// Compact calculator screen with horizontal swipe navigation
///
/// This screen provides a mobile-first, swipe-based interface for pizza
/// dough calculation with compact controls and horizontal navigation.
class CompactCalculatorScreen extends StatefulWidget {
  const CompactCalculatorScreen({super.key});

  @override
  State<CompactCalculatorScreen> createState() =>
      _CompactCalculatorScreenState();
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
        title: const Text(AppConstants.appShortName),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: _buildDrawer(context),
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
                    // Page 1: Setup with Live Recipe
                    const CompactInputPanel(),

                    // Page 2: Cooking Steps (only if recipe is available)
                    if (provider.showResults)
                      const CookingStepsPanel()
                    else
                      _buildCookingPrompt(provider),
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
        return 'Setup & Recipe';
      case 1:
        return 'Cooking Steps';
      default:
        return '';
    }
  }

  /// Build cooking prompt when no results available
  Widget _buildCookingPrompt(CalculatorProvider provider) {
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
              'Configure your pizza to see cooking steps',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              'Swipe left to setup your pizza',
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Keep awake toggle for page 0 - above the partition line
        if (_currentPage == 0) ...[
          _buildSubtleKeepAwakeToggle(context, provider),
          const SizedBox(height: 8),
        ],

        Container(
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
                // Navigation hints and buttons
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
                          provider.showResults
                              ? 'Swipe right for cooking steps'
                              : 'Recipe updates as you configure',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Quick navigate to steps button when recipe ready
                  if (provider.showResults)
                    ElevatedButton.icon(
                      onPressed: () {
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, size: 18),
                      label: const Text('Start Cooking'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                ] else ...[
                  // Back to setup button
                  TextButton.icon(
                    onPressed: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Recipe'),
                  ),
                  const Spacer(),

                  _buildNewRecipeButton(provider),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build calculate button
  Widget _buildCalculateButton(CalculatorProvider provider) {
    return ElevatedButton(
      onPressed: provider.isCalculating
          ? null
          : () async {
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
          : const Text('Recipe >'),
    );
  }

  /// Build new recipe button
  Widget _buildNewRecipeButton(CalculatorProvider provider) {
    return ElevatedButton.icon(
      onPressed: () => _showNewRecipeConfirmation(provider),
      icon: const Icon(Icons.refresh),
      label: const Text('New Recipe'),
    );
  }

  /// Show confirmation dialog before resetting recipe
  void _showNewRecipeConfirmation(CalculatorProvider provider) {
    // Only show confirmation if user has made selections or has a calculated recipe
    final hasContent =
        provider.showResults ||
        provider.diameterInput != AppConstants.defaultDiameter.toString() ||
        provider.thicknessInput !=
            AppConstants.defaultThicknessLevel.toString() ||
        provider.provingTimeInput !=
            AppConstants.defaultProvingTimeHours.toString() ||
        provider.numberOfPizzasInput !=
            AppConstants.defaultNumberOfPizzas.toString();

    if (!hasContent) {
      // No content to lose, just reset directly
      _resetToNewRecipe(provider);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange),
            SizedBox(width: 8),
            Text('Start New Recipe?'),
          ],
        ),
        content: const Text(
          'This will clear your current recipe and selections. Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _resetToNewRecipe(provider);
            },
            child: const Text('Start New'),
          ),
        ],
      ),
    );
  }

  /// Reset form and navigate to first page
  void _resetToNewRecipe(CalculatorProvider provider) {
    provider.resetForm();
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Build navigation drawer with Italian-inspired design
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Light green header
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
            ),
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pizza Genie',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.local_pizza,
                  title: 'Pizza Calculator',
                  subtitle: 'Create perfect dough recipes',
                  isSelected: true,
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'About Clevermonkey Pizza Genie',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.history_edu,
                  title: 'Pizza History',
                  subtitle: 'The story of pizza',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/pizza-history');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.restaurant,
                  title: 'Pizza Styles',
                  subtitle: 'Regional pizza varieties',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/pizza-styles');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.emoji_events,
                  title: 'Up Your Game',
                  subtitle: 'Pro tips for pizza perfection',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/up-your-game');
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'App preferences',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy',
                  subtitle: 'Privacy policy',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/privacy');
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.exit_to_app,
                  title: 'Close App',
                  subtitle: 'Exit Pizza Genie',
                  onTap: () => _showCloseAppConfirmation(context),
                ),
              ],
            ),
          ),

          // Clevermonkey logo footer
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
              ),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(
                  'assets/images/clevermonkey.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      subtitle: Text(subtitle),
      selected: isSelected,
      onTap: onTap,
    );
  }

  /// Build subtle keep awake toggle at bottom
  Widget _buildSubtleKeepAwakeToggle(
    BuildContext context,
    CalculatorProvider provider,
  ) {
    return Center(
      child: InkWell(
        onTap: () {
          provider.toggleKeepAwake();
          _handleKeepAwake(provider.keepAwake);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                provider.keepAwake ? Icons.lightbulb : Icons.lightbulb_outline,
                color: provider.keepAwake
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
                    : Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withOpacity(0.5),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                'Keep awake',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: provider.keepAwake
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                      : Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withOpacity(0.6),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleKeepAwake(bool keepAwake) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          keepAwake
              ? 'Screen will stay awake during cooking'
              : 'Screen will dim normally',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
      ),
    );
  }

  /// Show confirmation dialog before closing the app
  void _showCloseAppConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.orange),
            SizedBox(width: 8),
            Text('Close Pizza Genie?'),
          ],
        ),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Close drawer
              SystemNavigator.pop(); // Close app
            },
            child: const Text('Exit'),
          ),
        ],
      ),
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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
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
