import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

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
              const SizedBox(height: AppConstants.defaultPadding * 1.5),
              
              // Thickness selector with visual preview
              _buildThicknessSelector(context, provider),
              const SizedBox(height: AppConstants.defaultPadding * 1.5),
              
              // Proving time with slider
              _buildProvingTimeSlider(context, provider),
              const SizedBox(height: AppConstants.defaultPadding * 1.5),
              
              // Number of pizzas stepper
              _buildPizzaCountStepper(context, provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Quick presets
              _buildQuickPresets(context, provider),
              
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
        const SizedBox(height: 12),
        
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
    // Map diameter to display size (30-60px range)
    switch (diameter) {
      case 10.0: return 35;
      case 12.0: return 42;
      case 14.0: return 49;
      case 16.0: return 56;
      default: return 42;
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
        const SizedBox(height: 12),
        
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
    // Map thickness level to bar height (12-36px range)
    return 12.0 + (level * 4.8);
  }

  String _getShortStyleName(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin: return 'Thin';
      case ThicknessLevel.nyStyle: return 'NY';
      case ThicknessLevel.neapolitan: return 'Neap';
      case ThicknessLevel.grandma: return 'Grand';
      case ThicknessLevel.sicilian: return 'Sici';
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
        const SizedBox(height: 12),
        
        // Proving time slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: currentTime.toDouble(),
            min: 1,
            max: 48,
            divisions: 47,
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
            _buildTimeMarker(context, '1h\nQuick'),
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
}