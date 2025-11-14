import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../models/pizza_dough_recipe.dart';
import '../models/ingredient_measurement.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

/// Widget for displaying calculated pizza dough recipe with ingredients
///
/// This widget shows the calculated recipe results including all ingredient
/// quantities in both metric and imperial units, along with recipe metadata.
class IngredientDisplay extends StatelessWidget {
  const IngredientDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        if (!provider.showResults || provider.currentRecipe == null) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            _buildRecipeHeader(context, provider),
            const SizedBox(height: AppConstants.defaultPadding),
            
            _buildIngredientsCard(context, provider),
            const SizedBox(height: AppConstants.defaultPadding),
            
            if (provider.calculationWarnings.isNotEmpty)
              _buildWarningsCard(context, provider),
            
            _buildRecipeMetadata(context, provider),
            const SizedBox(height: AppConstants.defaultPadding),
            
            _buildActionButtons(context, provider),
          ],
        );
      },
    );
  }

  /// Build recipe header with title and key information
  Widget _buildRecipeHeader(BuildContext context, CalculatorProvider provider) {
    final recipe = provider.currentRecipe!;
    final parameters = recipe.calculatedFor;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_pizza,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${parameters.numberOfPizzas} × ${parameters.diameter.value.toStringAsFixed(0)}" ${recipe.pizzaStyleDescription}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${recipe.provingGuidance} • ${recipe.hydrationPercentage.toStringAsFixed(1)}% hydration',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Quick stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickStat(
                  context,
                  'Total Weight',
                  '${recipe.totalDoughWeight.toStringAsFixed(0)}g',
                  Icons.scale,
                ),
                _buildQuickStat(
                  context,
                  'Proving Time',
                  '${parameters.provingTimeHours.hours}h',
                  Icons.schedule,
                ),
                _buildQuickStat(
                  context,
                  'Prep Time',
                  '~${(provider.getEstimatedTimeMinutes() / 60).toStringAsFixed(1)}h total',
                  Icons.timer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build quick stat display
  Widget _buildQuickStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Build ingredients list card
  Widget _buildIngredientsCard(BuildContext context, CalculatorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.list_alt,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Ingredients list
            ...provider.currentMeasurements.map((measurement) {
              return _buildIngredientRow(context, measurement);
            }),
          ],
        ),
      ),
    );
  }

  /// Build individual ingredient row
  Widget _buildIngredientRow(BuildContext context, IngredientMeasurement measurement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Ingredient icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIngredientIcon(measurement.ingredientType),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // Ingredient details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  measurement.ingredientType.displayName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  measurement.dualDisplay,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Metric value (prominent)
          Text(
            measurement.metricDisplay,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// Get appropriate icon for each ingredient type
  IconData _getIngredientIcon(IngredientType type) {
    switch (type) {
      case IngredientType.flour:
        return Icons.grain;
      case IngredientType.water:
        return Icons.water_drop;
      case IngredientType.salt:
        return Icons.scatter_plot;
      case IngredientType.yeast:
        return Icons.bubble_chart;
      case IngredientType.sugar:
        return Icons.star_border;
      case IngredientType.oil:
        return Icons.opacity;
    }
  }

  /// Build warnings card if any calculation warnings exist
  Widget _buildWarningsCard(BuildContext context, CalculatorProvider provider) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tips & Considerations',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            ...provider.calculationWarnings.map((warning) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        warning,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Build recipe metadata (preparation steps preview)
  Widget _buildRecipeMetadata(BuildContext context, CalculatorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.menu_book,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Steps',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Show first few preparation steps
            ...provider.getPreparationSteps().take(3).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${index + 1}. $step',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }),
            
            if (provider.getPreparationSteps().length > 3)
              Text(
                '... and ${provider.getPreparationSteps().length - 3} more steps',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build action buttons for recipe management
  Widget _buildActionButtons(BuildContext context, CalculatorProvider provider) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              _showDetailedSteps(context, provider);
            },
            icon: const Icon(Icons.list_alt),
            label: const Text('View All Steps'),
          ),
        ),
        const SizedBox(width: AppConstants.defaultPadding),
        
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              provider.resetForm();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('New Recipe'),
          ),
        ),
      ],
    );
  }

  /// Show detailed preparation steps in a modal
  void _showDetailedSteps(BuildContext context, CalculatorProvider provider) {
    final steps = provider.getPreparationSteps();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                
                Text(
                  'Complete Preparation Steps',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              
                              Expanded(
                                child: Text(
                                  steps[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}