import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../models/ingredient_measurement.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

/// Compact results panel for horizontal layout
///
/// This widget displays recipe results in a mobile-optimized layout
/// with compact ingredient display and quick access to preparation steps.
class CompactResultsPanel extends StatelessWidget {
  const CompactResultsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        if (!provider.showResults || provider.currentRecipe == null) {
          return const Center(
            child: Text('No recipe calculated'),
          );
        }

        final recipe = provider.currentRecipe!;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe summary header
              _buildRecipeSummary(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Ingredients grid
              _buildIngredientsGrid(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Quick preparation overview
              _buildQuickPreparation(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Action buttons
              _buildActionButtons(context, provider),
            ],
          ),
        );
      },
    );
  }

  /// Build recipe summary at the top
  Widget _buildRecipeSummary(BuildContext context, CalculatorProvider provider) {
    final recipe = provider.currentRecipe!;
    final parameters = recipe.calculatedFor;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Main recipe title
            Row(
              children: [
                Icon(
                  Icons.local_pizza,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
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
                        '${recipe.hydrationPercentage.toStringAsFixed(1)}% hydration • ${recipe.totalDoughWeight.toStringAsFixed(0)}g total',
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
                _buildStatItem(
                  context,
                  '⏱️',
                  '${parameters.provingTimeHours.hours}h',
                  'Proving',
                ),
                _buildStatItem(
                  context,
                  '🕒',
                  '~${(provider.getEstimatedTimeMinutes() / 60).toStringAsFixed(1)}h',
                  'Total Time',
                ),
                _buildStatItem(
                  context,
                  '⚖️',
                  '${(recipe.totalDoughWeight / parameters.numberOfPizzas).toStringAsFixed(0)}g',
                  'Per Pizza',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String emoji,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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

  /// Build compact ingredients grid
  Widget _buildIngredientsGrid(BuildContext context, CalculatorProvider provider) {
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
                  size: 20,
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
            const SizedBox(height: 12),
            
            // Ingredients in compact grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: provider.currentMeasurements.map((measurement) {
                return _buildIngredientTile(context, measurement);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual ingredient tile
  Widget _buildIngredientTile(BuildContext context, IngredientMeasurement measurement) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                _getIngredientEmoji(measurement.ingredientType),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  measurement.ingredientType.displayName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                measurement.metricDisplay,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                measurement.imperialDisplay,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getIngredientEmoji(IngredientType type) {
    switch (type) {
      case IngredientType.flour:
        return '🌾';
      case IngredientType.water:
        return '💧';
      case IngredientType.salt:
        return '🧂';
      case IngredientType.yeast:
        return '🦠';
      case IngredientType.sugar:
        return '🍯';
      case IngredientType.oil:
        return '🫒';
    }
  }

  /// Build quick preparation overview
  Widget _buildQuickPreparation(BuildContext context, CalculatorProvider provider) {
    final steps = provider.getPreparationSteps();
    final keySteps = steps.take(3).toList();
    
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
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Start',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Step 1-3 of ${steps.length}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // First 3 steps
            ...keySteps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        step,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            // View all steps button
            if (steps.length > 3)
              Center(
                child: TextButton.icon(
                  onPressed: () => _showAllSteps(context, provider),
                  icon: const Icon(Icons.more_horiz, size: 18),
                  label: Text('View all ${steps.length} steps'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons(BuildContext context, CalculatorProvider provider) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showAllSteps(context, provider),
            icon: const Icon(Icons.list_alt, size: 18),
            label: const Text('All Steps'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showIngredientDetails(context, provider),
            icon: const Icon(Icons.info_outline, size: 18),
            label: const Text('Details'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// Show all preparation steps in modal
  void _showAllSteps(BuildContext context, CalculatorProvider provider) {
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
                // Handle bar
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
                  'Complete Recipe Steps',
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
                      final isKey = index < 3; // Highlight key mixing steps
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isKey 
                            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
                            : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isKey
                              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                              : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isKey 
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isKey
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.surface,
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

  /// Show ingredient details modal
  void _showIngredientDetails(BuildContext context, CalculatorProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recipe Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...provider.currentMeasurements.map((measurement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Text(
                        _getIngredientEmoji(measurement.ingredientType),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              measurement.ingredientType.displayName,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(measurement.dualDisplay),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              
              if (provider.calculationWarnings.isNotEmpty) ...[
                const Divider(),
                const Text(
                  'Tips:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                ...provider.calculationWarnings.map((warning) {
                  return Text('• $warning', style: const TextStyle(fontSize: 13));
                }),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}