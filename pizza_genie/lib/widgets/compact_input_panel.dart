import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/calculator_provider.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';
import '../models/ingredient_measurement.dart';

/// Compact input panel with sliders, steppers and touch controls
///
/// This widget provides a mobile-optimized interface using sliders,
/// steppers, and tap buttons instead of traditional form fields.
class CompactInputPanel extends StatelessWidget {
  const CompactInputPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pizza diameter selector
              _buildDiameterSelector(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Thickness selector with visual preview
              _buildThicknessSelector(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Proving time with slider
              _buildProvingTimeSlider(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Quick presets (temporarily hidden)
              // _buildQuickPresets(context, provider),
              // const SizedBox(height: AppConstants.defaultPadding * 1.5),
              
              // Live ingredients preview
              _buildLiveIngredientsPreview(context, provider),
              
              // Validation errors
              if (provider.hasValidationErrors)
                _buildCompactErrors(context, provider),
            ],
          ),
        );
      },
    );
  }

  /// Build pizza diameter selector with visual size indicators
  Widget _buildDiameterSelector(BuildContext context, CalculatorProvider provider) {
    final currentDiameter = double.tryParse(provider.diameterInput) ?? 12.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.straighten,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Pizza Size',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              '${currentDiameter.toStringAsFixed(0)}"',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Visual diameter selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: AppConstants.allowedDiameters.map((diameter) {
            final isSelected = currentDiameter == diameter;
            final size = _getDiameterDisplaySize(diameter);
            
            return GestureDetector(
              onTap: () => provider.updateDiameter(diameter.toString()),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                      border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          )
                        : null,
                    ),
                    child: Center(
                      child: Text(
                        '${diameter.toStringAsFixed(0)}"',
                        style: TextStyle(
                          color: isSelected
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getDiameterDescription(diameter),
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  double _getDiameterDisplaySize(double diameter) {
    // Map diameter to display size (28-50px range) - more compact
    switch (diameter) {
      case 10.0: return 30;
      case 12.0: return 36;
      case 14.0: return 42;
      case 16.0: return 48;
      default: return 36;
    }
  }

  String _getDiameterDescription(double diameter) {
    switch (diameter) {
      case 10.0: return 'Personal';
      case 12.0: return 'Classic';
      case 14.0: return 'Large';
      case 16.0: return 'XL';
      default: return '';
    }
  }

  /// Build thickness selector with visual thickness bars
  Widget _buildThicknessSelector(BuildContext context, CalculatorProvider provider) {
    final currentThickness = int.tryParse(provider.thicknessInput) ?? 3;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.layers,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Crust Style',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              ThicknessLevel.fromValue(currentThickness).displayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Visual thickness selector
        Row(
          children: ThicknessLevel.values.map((thickness) {
            final isSelected = currentThickness == thickness.value;
            
            return Expanded(
              child: GestureDetector(
                onTap: () => provider.updateThickness(thickness.value.toString()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    children: [
                      // Thickness bar visualization
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: _getThicknessBarHeight(thickness.value),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      
                      // Level number
                      Text(
                        thickness.value.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      
                      // Style name (abbreviated)
                      Text(
                        _getShortStyleName(thickness),
                        style: TextStyle(
                          fontSize: 9,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  double _getThicknessBarHeight(int level) {
    // Map thickness level to bar height (8-28px range) - more compact
    return 8.0 + (level * 4.0);
  }

  String _getShortStyleName(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin: return 'Very Thin';
      case ThicknessLevel.nyStyle: return 'NY Style';
      case ThicknessLevel.neapolitan: return 'Neapolitan';
      case ThicknessLevel.grandma: return 'Grandma';
      case ThicknessLevel.sicilian: return 'Sicilian';
    }
  }

  /// Build proving time slider with time indicators
  Widget _buildProvingTimeSlider(BuildContext context, CalculatorProvider provider) {
    final currentTime = int.tryParse(provider.provingTimeInput) ?? 24;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.schedule,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Proving Time',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              '${currentTime}h',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        Text(
          _getProvingTimeDescription(currentTime),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        
        // Proving time slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: currentTime.toDouble(),
            min: 2,
            max: 48,
            divisions: 46,
            label: '${currentTime}h',
            onChanged: (value) {
              provider.updateProvingTime(value.round().toString());
            },
          ),
        ),
        
        // Time markers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTimeMarker(context, '2h\nQuick'),
            _buildTimeMarker(context, '8h\nSame day'),
            _buildTimeMarker(context, '24h\nOvernight'),
            _buildTimeMarker(context, '48h\nSlow'),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeMarker(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }

  String _getProvingTimeDescription(int hours) {
    if (hours <= 4) return 'Quick rise - higher yeast, same day baking';
    if (hours <= 12) return 'Balanced fermentation - good flavor development';
    if (hours <= 24) return 'Overnight prove - excellent flavor and texture';
    return 'Slow fermentation - maximum flavor and digestibility';
  }


  /// Build compact quantity control for ingredients header
  Widget _buildCompactQuantityControl(BuildContext context, CalculatorProvider provider) {
    final currentCount = int.tryParse(provider.numberOfPizzasInput) ?? 1;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease button
        GestureDetector(
          onTap: currentCount > 1 ? () {
            provider.updateNumberOfPizzas((currentCount - 1).toString());
          } : null,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: currentCount > 1 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.remove,
              size: 14,
              color: currentCount > 1 
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Quantity display
        Text(
          'x$currentCount',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Increase button
        GestureDetector(
          onTap: currentCount < 10 ? () {
            provider.updateNumberOfPizzas((currentCount + 1).toString());
          } : null,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: currentCount < 10 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add,
              size: 14,
              color: currentCount < 10 
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  /// Build pizza count stepper
  Widget _buildPizzaCountStepper(BuildContext context, CalculatorProvider provider) {
    final currentCount = int.tryParse(provider.numberOfPizzasInput) ?? 1;
    
    return Row(
      children: [
        Icon(
          Icons.local_pizza,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'Quantity',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        
        // Stepper controls
        Row(
          children: [
            IconButton(
              onPressed: currentCount > 1 ? () {
                provider.updateNumberOfPizzas((currentCount - 1).toString());
              } : null,
              icon: const Icon(Icons.remove_circle_outline),
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  currentCount.toString(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            
            IconButton(
              onPressed: currentCount < 10 ? () {
                provider.updateNumberOfPizzas((currentCount + 1).toString());
              } : null,
              icon: const Icon(Icons.add_circle_outline),
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build quick preset buttons
  Widget _buildQuickPresets(BuildContext context, CalculatorProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Presets',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        Row(
          children: [
            Expanded(
              child: _buildPresetChip(
                context,
                'NY Style',
                () => _applyPreset(provider, 12.0, 2, 24, 1),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPresetChip(
                context,
                'Neapolitan',
                () => _applyPreset(provider, 12.0, 3, 24, 1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        Row(
          children: [
            Expanded(
              child: _buildPresetChip(
                context,
                'Quick (4h)',
                () => _applyPreset(provider, 14.0, 2, 4, 1),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPresetChip(
                context,
                'Party Size',
                () => _applyPreset(provider, 16.0, 3, 8, 2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPresetChip(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  void _applyPreset(
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

  /// Build live ingredients preview that updates as user changes selections
  Widget _buildLiveIngredientsPreview(BuildContext context, CalculatorProvider provider) {
    // Auto-calculate on every build to keep ingredients live
    _autoCalculateIfValid(provider);
    
    return Card(
      elevation: 3,
      shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ],
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Your Recipe',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                const Spacer(),
                
                // Quantity multiplier control
                if (provider.showResults && provider.currentRecipe != null) ...[
                  _buildCompactQuantityControl(context, provider),
                  const SizedBox(width: 12),
                ],
                
                
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
                              size: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Ingredients preview
            if (provider.showResults && provider.currentMeasurements.isNotEmpty) ...[
              // Compact ingredients grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 2.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: provider.currentMeasurements.map((measurement) {
                  return _buildCompactIngredientTile(context, measurement);
                }).toList(),
              ),
              
              // Hydration display and save option
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hydration info (left side)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.water_drop,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Hydration: ${provider.currentRecipe!.hydrationPercentage.toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  // Save as default button (right side)
                  InkWell(
                    onTap: () => _saveAsDefault(context, provider),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bookmark_outline,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Save as default',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
            ] else ...[
              // Placeholder when no valid inputs
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Configure your pizza to see ingredients',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
    );
  }

  /// Auto-calculate recipe when inputs are valid (silent calculation)
  void _autoCalculateIfValid(CalculatorProvider provider) {
    // Only calculate if we don't have results yet or inputs changed
    if (!provider.hasValidationErrors && !provider.isCalculating) {
      // Silent calculation without UI feedback
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.calculateRecipe();
      });
    }
  }

  /// Build compact ingredient tile for live preview
  Widget _buildCompactIngredientTile(BuildContext context, IngredientMeasurement measurement) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.15),
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                _getIngredientEmoji(measurement.ingredientType),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  measurement.ingredientType.displayName,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Consumer<CalculatorProvider>(
            builder: (context, prov, child) {
              final displayText = prov.measurementSystem == MeasurementSystem.metric
                ? _roundToGram(measurement.metricDisplay)
                : measurement.imperialDisplay;
              
              return Text(
                displayText,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 11,
                ),
              );
            },
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

  Widget _buildQuickStat(
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
            Text(emoji, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  /// Build compact error display
  Widget _buildCompactErrors(BuildContext context, CalculatorProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: Theme.of(context).colorScheme.error,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              provider.validationErrors.values.first,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Save current recipe settings as default
  void _saveAsDefault(BuildContext context, CalculatorProvider provider) async {
    try {
      await provider.saveAsDefault();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Recipe saved as default'),
              ],
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(
              bottom: 80,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save default: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}