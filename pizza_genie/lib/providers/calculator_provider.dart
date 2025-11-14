import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/calculator_parameters.dart';
import '../models/pizza_dough_recipe.dart';
import '../models/ingredient_measurement.dart';
import '../services/calculation_service.dart';
import '../services/validation_service.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

/// Provider for managing pizza calculator state
///
/// This provider manages the calculator form state, validation,
/// calculations, and persistence using SharedPreferences.
class CalculatorProvider extends ChangeNotifier {
  CalculatorProvider() {
    _loadSavedParameters();
  }

  // Form state
  CalculatorParameters _parameters = CalculatorParameters.defaults();
  PizzaDoughRecipe? _currentRecipe;
  List<IngredientMeasurement> _currentMeasurements = [];
  
  // UI state
  bool _isCalculating = false;
  bool _showResults = false;
  Map<String, String> _validationErrors = {};
  List<String> _calculationWarnings = [];
  MeasurementSystem _measurementSystem = MeasurementSystem.metric;
  bool _keepAwake = true; // Default to on for cooking convenience

  // Form field controllers - these would be managed by form widgets
  String _diameterInput = AppConstants.defaultDiameter.toString();
  String _thicknessInput = AppConstants.defaultThicknessLevel.toString();
  String _provingTimeInput = AppConstants.defaultProvingTimeHours.toString();
  String _numberOfPizzasInput = AppConstants.defaultNumberOfPizzas.toString();

  // Getters
  CalculatorParameters get parameters => _parameters;
  PizzaDoughRecipe? get currentRecipe => _currentRecipe;
  List<IngredientMeasurement> get currentMeasurements => _currentMeasurements;
  bool get isCalculating => _isCalculating;
  bool get showResults => _showResults;
  bool get hasValidationErrors => _validationErrors.isNotEmpty;
  Map<String, String> get validationErrors => Map.from(_validationErrors);
  List<String> get calculationWarnings => List.from(_calculationWarnings);
  MeasurementSystem get measurementSystem => _measurementSystem;
  bool get keepAwake => _keepAwake;
  
  // Form input getters
  String get diameterInput => _diameterInput;
  String get thicknessInput => _thicknessInput;
  String get provingTimeInput => _provingTimeInput;
  String get numberOfPizzasInput => _numberOfPizzasInput;

  /// Update diameter input and validate
  void updateDiameter(String value) {
    _diameterInput = value;
    _validateField('diameter', value);
    notifyListeners();
  }

  /// Update thickness input and validate
  void updateThickness(String value) {
    _thicknessInput = value;
    _validateField('thickness', value);
    notifyListeners();
  }

  /// Update proving time input and validate
  void updateProvingTime(String value) {
    _provingTimeInput = value;
    _validateField('provingTime', value);
    notifyListeners();
  }

  /// Update number of pizzas input and validate
  void updateNumberOfPizzas(String value) {
    _numberOfPizzasInput = value;
    _validateField('numberOfPizzas', value);
    notifyListeners();
  }

  /// Toggle between metric and imperial measurement systems
  void toggleMeasurementSystem() {
    _measurementSystem = _measurementSystem == MeasurementSystem.metric 
      ? MeasurementSystem.imperial 
      : MeasurementSystem.metric;
    notifyListeners();
  }

  /// Toggle keep awake functionality
  void toggleKeepAwake() {
    _keepAwake = !_keepAwake;
    notifyListeners();
  }

  /// Validate a single form field
  void _validateField(String fieldName, String value) {
    String? error;
    
    switch (fieldName) {
      case 'diameter':
        error = ValidationService.validateDiameter(value);
        break;
      case 'thickness':
        error = ValidationService.validateThickness(value);
        break;
      case 'provingTime':
        error = ValidationService.validateProvingTime(value);
        break;
      case 'numberOfPizzas':
        error = ValidationService.validateNumberOfPizzas(value);
        break;
    }

    if (error != null) {
      _validationErrors[fieldName] = error;
    } else {
      _validationErrors.remove(fieldName);
    }
  }

  /// Validate all form fields at once
  bool validateAllFields() {
    final errors = ValidationService.validateAllParameters(
      diameter: _diameterInput,
      thickness: _thicknessInput,
      provingTime: _provingTimeInput,
      numberOfPizzas: _numberOfPizzasInput,
    );

    _validationErrors = errors;
    notifyListeners();
    
    return errors.isEmpty;
  }

  /// Calculate pizza recipe from current form inputs
  Future<bool> calculateRecipe() async {
    _isCalculating = true;
    _showResults = false;
    notifyListeners();

    try {
      // Validate inputs first
      if (!validateAllFields()) {
        _isCalculating = false;
        notifyListeners();
        return false;
      }

      // Create parameters from validated inputs
      _parameters = CalculatorParameters.validated(
        diameter: double.parse(_diameterInput),
        thicknessLevel: int.parse(_thicknessInput),
        provingTimeHours: int.parse(_provingTimeInput),
        numberOfPizzas: int.parse(_numberOfPizzasInput),
      );

      // Check for calculation warnings
      _calculationWarnings = CalculationService.validateCalculationParameters(_parameters);

      // Calculate recipe with measurements
      final recipeWithMeasurements = CalculationService.calculateRecipeWithMeasurements(_parameters);
      
      _currentRecipe = recipeWithMeasurements.recipe;
      _currentMeasurements = recipeWithMeasurements.measurements;
      
      // Save parameters for next session
      await _saveParameters();
      
      _showResults = true;
      _isCalculating = false;
      notifyListeners();
      
      return true;

    } catch (e) {
      _isCalculating = false;
      _validationErrors['general'] = 'Calculation failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Reset form to default values
  void resetForm() {
    _parameters = CalculatorParameters.defaults();
    _currentRecipe = null;
    _currentMeasurements.clear();
    _showResults = false;
    _validationErrors.clear();
    _calculationWarnings.clear();
    _keepAwake = true; // Keep default to on
    
    _diameterInput = AppConstants.defaultDiameter.toString();
    _thicknessInput = AppConstants.defaultThicknessLevel.toString();
    _provingTimeInput = AppConstants.defaultProvingTimeHours.toString();
    _numberOfPizzasInput = AppConstants.defaultNumberOfPizzas.toString();
    
    notifyListeners();
  }

  /// Clear current results but keep form values
  void clearResults() {
    _currentRecipe = null;
    _currentMeasurements.clear();
    _showResults = false;
    _calculationWarnings.clear();
    notifyListeners();
  }

  /// Get measurement for a specific ingredient
  IngredientMeasurement? getMeasurement(IngredientType type) {
    try {
      return _currentMeasurements.firstWhere(
        (m) => m.ingredientType == type,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get preparation steps for current recipe
  List<String> getPreparationSteps() {
    if (_currentRecipe == null) return [];
    return CalculationService.getPreparationSteps(_parameters);
  }

  /// Get estimated total time for current recipe
  int getEstimatedTimeMinutes() {
    return CalculationService.estimateTotalTimeMinutes(_parameters);
  }

  /// Load saved parameters from SharedPreferences
  Future<void> _loadSavedParameters() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedJson = prefs.getString(AppConstants.prefsKeys['lastParameters']!);
      
      if (savedJson != null) {
        // Note: In a real app, you'd use proper JSON parsing
        // For now, we'll just load defaults
        _parameters = CalculatorParameters.defaults();
        
        // Update form inputs to match loaded parameters
        _diameterInput = _parameters.diameter.value.toString();
        _thicknessInput = _parameters.thicknessLevel.value.toString();
        _provingTimeInput = _parameters.provingTimeHours.hours.toString();
        _numberOfPizzasInput = _parameters.numberOfPizzas.toString();
        
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load saved parameters: $e');
    }
  }

  /// Save current parameters to SharedPreferences
  Future<void> _saveParameters() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = _parameters.toJson();
      // Note: In a real app, you'd use proper JSON encoding
      await prefs.setString(AppConstants.prefsKeys['lastParameters']!, json.toString());
    } catch (e) {
      debugPrint('Failed to save parameters: $e');
    }
  }

  /// Set parameters programmatically (for testing or presets)
  void setParameters(CalculatorParameters parameters) {
    _parameters = parameters;
    
    _diameterInput = parameters.diameter.value.toString();
    _thicknessInput = parameters.thicknessLevel.value.toString();
    _provingTimeInput = parameters.provingTimeHours.hours.toString();
    _numberOfPizzasInput = parameters.numberOfPizzas.toString();
    
    // Clear any existing validation errors
    _validationErrors.clear();
    
    notifyListeners();
  }

  /// Get validation hint for a specific field
  String? getValidationHint(String fieldName) {
    return ValidationService.validationHints[fieldName];
  }
}