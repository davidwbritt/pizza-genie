import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

/// Calculator form widget for pizza dough parameters input
///
/// This widget provides form fields for diameter, thickness, proving time,
/// and number of pizzas with real-time validation and user guidance.
class CalculatorForm extends StatefulWidget {
  const CalculatorForm({super.key});

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Text editing controllers for form fields
  late final TextEditingController _diameterController;
  late final TextEditingController _thicknessController;
  late final TextEditingController _provingTimeController;
  late final TextEditingController _numberOfPizzasController;

  // Listener methods for controllers
  void _diameterListener() {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    provider.updateDiameter(_diameterController.text);
  }
  
  void _thicknessListener() {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    provider.updateThickness(_thicknessController.text);
  }
  
  void _provingTimeListener() {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    provider.updateProvingTime(_provingTimeController.text);
  }
  
  void _numberOfPizzasListener() {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    provider.updateNumberOfPizzas(_numberOfPizzasController.text);
  }

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with provider values
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    _diameterController = TextEditingController(text: provider.diameterInput);
    _thicknessController = TextEditingController(text: provider.thicknessInput);
    _provingTimeController = TextEditingController(text: provider.provingTimeInput);
    _numberOfPizzasController = TextEditingController(text: provider.numberOfPizzasInput);
    
    // Add listeners to controllers
    _diameterController.addListener(_diameterListener);
    _thicknessController.addListener(_thicknessListener);
    _provingTimeController.addListener(_provingTimeListener);
    _numberOfPizzasController.addListener(_numberOfPizzasListener);
  }

  @override
  void dispose() {
    _diameterController.dispose();
    _thicknessController.dispose();
    _provingTimeController.dispose();
    _numberOfPizzasController.dispose();
    super.dispose();
  }

  /// Update form controllers to match provider state (for presets)
  void _updateControllersFromProvider(CalculatorProvider provider) {
    // Only update if the controller text doesn't match provider state
    // Temporarily remove listeners to avoid circular updates
    if (_diameterController.text != provider.diameterInput) {
      _diameterController.removeListener(_diameterListener);
      _diameterController.text = provider.diameterInput;
      _diameterController.addListener(_diameterListener);
    }
    if (_thicknessController.text != provider.thicknessInput) {
      _thicknessController.removeListener(_thicknessListener);
      _thicknessController.text = provider.thicknessInput;
      _thicknessController.addListener(_thicknessListener);
    }
    if (_provingTimeController.text != provider.provingTimeInput) {
      _provingTimeController.removeListener(_provingTimeListener);
      _provingTimeController.text = provider.provingTimeInput;
      _provingTimeController.addListener(_provingTimeListener);
    }
    if (_numberOfPizzasController.text != provider.numberOfPizzasInput) {
      _numberOfPizzasController.removeListener(_numberOfPizzasListener);
      _numberOfPizzasController.text = provider.numberOfPizzasInput;
      _numberOfPizzasController.addListener(_numberOfPizzasListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        // Update controllers when provider state changes (e.g., from presets)
        _updateControllersFromProvider(provider);
        
        return Form(
          key: _formKey,
          child: Column(
            children: [
              _buildDiameterField(provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              _buildThicknessField(provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              _buildProvingTimeField(provider),
              const SizedBox(height: AppConstants.defaultPadding),
              
              _buildNumberOfPizzasField(provider),
              const SizedBox(height: AppConstants.defaultPadding * 2),
              
              _buildCalculateButton(provider),
              
              if (provider.hasValidationErrors)
                _buildErrorSummary(provider),
            ],
          ),
        );
      },
    );
  }

  /// Build diameter input field with dropdown selection
  Widget _buildDiameterField(CalculatorProvider provider) {
    final error = provider.validationErrors['diameter'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pizza Diameter (inches)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        DropdownButtonFormField<double>(
          value: AppConstants.allowedDiameters.contains(
            double.tryParse(_diameterController.text)
          ) ? double.tryParse(_diameterController.text) : null,
          decoration: InputDecoration(
            hintText: 'Select pizza size',
            errorText: error,
            prefixIcon: const Icon(Icons.straighten),
          ),
          items: AppConstants.allowedDiameters.map((diameter) {
            return DropdownMenuItem(
              value: diameter,
              child: Text('${diameter.toStringAsFixed(0)}" pizza'),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _diameterController.text = value.toString();
            }
          },
        ),
        
        if (error == null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              provider.getValidationHint('diameter') ?? '',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  /// Build thickness level field with style descriptions
  Widget _buildThicknessField(CalculatorProvider provider) {
    final error = provider.validationErrors['thickness'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Crust Thickness',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        DropdownButtonFormField<int>(
          value: int.tryParse(_thicknessController.text),
          decoration: InputDecoration(
            hintText: 'Select crust style',
            errorText: error,
            prefixIcon: const Icon(Icons.layers),
          ),
          items: ThicknessLevel.values.map((thickness) {
            return DropdownMenuItem(
              value: thickness.value,
              child: Text('${thickness.value} - ${thickness.displayName}'),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _thicknessController.text = value.toString();
            }
          },
        ),
        
        if (error == null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Scale 1-5: Very Thin → NY Style → Neapolitan → Grandma → Sicilian',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  /// Build proving time input field
  Widget _buildProvingTimeField(CalculatorProvider provider) {
    final error = provider.validationErrors['provingTime'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Proving Time (hours)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        TextFormField(
          controller: _provingTimeController,
          decoration: InputDecoration(
            hintText: 'Enter hours (1-48)',
            errorText: error,
            prefixIcon: const Icon(Icons.schedule),
            suffixText: 'hours',
          ),
          keyboardType: TextInputType.number,
        ),
        
        if (error == null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Longer proving = better flavor. Try 24h for best results!',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  /// Build number of pizzas input field
  Widget _buildNumberOfPizzasField(CalculatorProvider provider) {
    final error = provider.validationErrors['numberOfPizzas'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Pizzas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        TextFormField(
          controller: _numberOfPizzasController,
          decoration: InputDecoration(
            hintText: 'How many pizzas?',
            errorText: error,
            prefixIcon: const Icon(Icons.local_pizza),
            suffixText: 'pizzas',
          ),
          keyboardType: TextInputType.number,
        ),
        
        if (error == null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Recipe will scale ingredients for multiple pizzas',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  /// Build calculate button
  Widget _buildCalculateButton(CalculatorProvider provider) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: provider.isCalculating ? null : () async {
          // Hide keyboard
          FocusScope.of(context).unfocus();
          
          // Calculate recipe
          final success = await provider.calculateRecipe();
          
          if (!success) {
            // Scroll to show errors if needed
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fix the errors above'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        child: provider.isCalculating
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 12),
                Text('Calculating...'),
              ],
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calculate),
                SizedBox(width: 8),
                Text('Calculate Recipe'),
              ],
            ),
      ),
    );
  }

  /// Build error summary display
  Widget _buildErrorSummary(CalculatorProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.onErrorContainer,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Please fix the following:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...provider.validationErrors.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(left: 28, bottom: 4),
              child: Text(
                '• ${entry.value}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontSize: 14,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Quick preset buttons for common pizza configurations
class PresetButtons extends StatelessWidget {
  const PresetButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Presets',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _buildPresetButton(
                    context,
                    'NY Style',
                    '12" • Level 2 • 24h',
                    () => _applyPreset(provider, 12.0, 2, 24, 1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPresetButton(
                    context,
                    'Neapolitan',
                    '12" • Level 3 • 24h',
                    () => _applyPreset(provider, 12.0, 3, 24, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _buildPresetButton(
                    context,
                    'Quick & Easy',
                    '14" • Level 2 • 4h',
                    () => _applyPreset(provider, 14.0, 2, 4, 1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPresetButton(
                    context,
                    'Party Size',
                    '16" • Level 3 • 8h',
                    () => _applyPreset(provider, 16.0, 3, 8, 2),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPresetButton(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return OutlinedButton(
      onPressed: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
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
    // Clear any existing results first
    provider.clearResults();
    
    // Apply preset values
    provider.updateDiameter(diameter.toString());
    provider.updateThickness(thickness.toString());
    provider.updateProvingTime(provingTime.toString());
    provider.updateNumberOfPizzas(numberOfPizzas.toString());
  }
}