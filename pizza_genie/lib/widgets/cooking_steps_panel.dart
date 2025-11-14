import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../models/ingredient_measurement.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

/// Cooking steps panel - third screen in horizontal layout
///
/// This screen provides step-by-step cooking instructions with
/// ingredient summary and keep-awake functionality.
class CookingStepsPanel extends StatefulWidget {
  const CookingStepsPanel({super.key});

  @override
  State<CookingStepsPanel> createState() => _CookingStepsPanelState();
}

class _CookingStepsPanelState extends State<CookingStepsPanel> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        if (!provider.showResults || provider.currentRecipe == null) {
          return const Center(
            child: Text('No recipe available'),
          );
        }

        final steps = provider.getPreparationSteps();

        return Column(
          children: [
            // Fixed header with ingredients summary
            _buildIngredientsHeader(context, provider),
            
            // Steps content
            Expanded(
              child: _buildStepsList(context, steps),
            ),
            
            // Step navigation
            _buildStepNavigation(context, steps),
            
            // Subtle keep awake toggle at bottom
            _buildSubtleKeepAwakeToggle(context, provider),
          ],
        );
      },
    );
  }

  /// Build compact ingredients summary at top
  Widget _buildIngredientsHeader(BuildContext context, CalculatorProvider provider) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              
              // Measurement system toggle
              InkWell(
                onTap: () => provider.toggleMeasurementSystem(),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        provider.measurementSystem == MeasurementSystem.metric ? 'g/ml' : 'cups',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.swap_horiz,
                        size: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Compact ingredients list
          Wrap(
            spacing: 16,
            runSpacing: 4,
            children: provider.currentMeasurements.map((measurement) {
              final displayText = provider.measurementSystem == MeasurementSystem.metric
                ? _roundToGram(measurement.metricDisplay)
                : measurement.imperialDisplay;
              
              return Text(
                '${_getIngredientEmoji(measurement.ingredientType)} $displayText',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getIngredientEmoji(IngredientType type) {
    switch (type) {
      case IngredientType.flour: return '🌾';
      case IngredientType.water: return '💧';
      case IngredientType.salt: return '🧂';
      case IngredientType.yeast: return '🦠';
      case IngredientType.sugar: return '🍯';
      case IngredientType.oil: return '🫒';
    }
  }

  /// Round metric measurements to nearest gram for practical kitchen use
  String _roundToGram(String metricDisplay) {
    // Extract the number and unit from the display string
    final regex = RegExp(r'(\d+\.?\d*)(g|ml)');
    final match = regex.firstMatch(metricDisplay);
    
    if (match != null) {
      final value = double.parse(match.group(1)!);
      final unit = match.group(2)!;
      final rounded = value.round();
      return '$rounded$unit';
    }
    
    return metricDisplay; // Return original if parsing fails
  }

  /// Build subtle keep awake toggle at bottom
  Widget _buildSubtleKeepAwakeToggle(BuildContext context, CalculatorProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 8),
      child: Center(
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
                    : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  'Keep awake',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: provider.keepAwake 
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                      : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleKeepAwake(bool keepAwake) {
    // In a real app, you'd use a plugin like 'wakelock' to keep screen awake
    // For now, just show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          keepAwake 
            ? 'Screen will stay awake during cooking'
            : 'Screen will dim normally',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 100,
          left: 16,
          right: 16,
        ),
      ),
    );
  }

  /// Build steps list with progress tracking
  Widget _buildStepsList(BuildContext context, List<String> steps) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final isCompleted = index < _currentStep;
        final isCurrent = index == _currentStep;
        final isUpcoming = index > _currentStep;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentStep = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCurrent
                ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
                : isCompleted
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCurrent
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  : isCompleted
                    ? Theme.of(context).colorScheme.outline.withOpacity(0.2)
                    : Theme.of(context).colorScheme.outline.withOpacity(0.1),
                width: isCurrent ? 2 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isCompleted
                      ? Theme.of(context).colorScheme.primary
                      : isCurrent
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                        : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: isCompleted
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        )
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent || isCompleted
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Step content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                          color: isUpcoming
                            ? Theme.of(context).colorScheme.onSurfaceVariant
                            : null,
                        ),
                      ),
                      
                      // Add timing hints for key steps
                      if (_getStepTiming(index) != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            _getStepTiming(index)!,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                // Current step indicator
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'CURRENT',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _getStepTiming(int stepIndex) {
    switch (stepIndex) {
      case 1: return '⏱️ Mix until combined';
      case 2: return '⏱️ Wait 5 minutes for foam';
      case 7: return '⏱️ Knead 8-10 minutes';
      default: return null;
    }
  }

  /// Build step navigation at bottom
  Widget _buildStepNavigation(BuildContext context, List<String> steps) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Previous step
            TextButton.icon(
              onPressed: _currentStep > 0 ? () {
                setState(() {
                  _currentStep--;
                });
              } : null,
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text('Previous'),
            ),
            
            const Spacer(),
            
            // Progress indicator
            Text(
              'Step ${_currentStep + 1} of ${steps.length}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const Spacer(),
            
            // Next step / Mark complete
            TextButton.icon(
              onPressed: _currentStep < steps.length - 1 ? () {
                setState(() {
                  _currentStep++;
                });
              } : () {
                // All steps completed
                _showCompletionDialog(context);
              },
              icon: Icon(
                _currentStep < steps.length - 1 
                  ? Icons.arrow_forward 
                  : Icons.check_circle,
                size: 18,
              ),
              label: Text(
                _currentStep < steps.length - 1 
                  ? 'Next' 
                  : 'Done!',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Text('🎉 '),
            Text('Pizza Complete!'),
          ],
        ),
        content: const Text(
          'Congratulations! Your pizza dough is ready to shape and bake. '
          'Enjoy your homemade pizza!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Reset form and step for new recipe
              final provider = Provider.of<CalculatorProvider>(context, listen: false);
              provider.resetForm();
              setState(() {
                _currentStep = 0;
              });
            },
            child: const Text('New Recipe'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }
}