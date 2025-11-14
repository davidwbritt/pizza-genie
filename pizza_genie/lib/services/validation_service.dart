import '../constants/constants.dart';
import '../constants/enums.dart';

/// Service for validating user inputs in the pizza dough calculator
///
/// This service provides validation methods for all calculator parameters,
/// returning error messages for invalid inputs and null for valid ones.
class ValidationService {
  /// Validate pizza diameter input
  ///
  /// Returns error message if invalid, null if valid.
  static String? validateDiameter(String? input) {
    if (input == null || input.trim().isEmpty) {
      return AppConstants.errorMessages['emptyDiameter'];
    }

    final double? diameter = double.tryParse(input.trim());
    if (diameter == null) {
      return AppConstants.errorMessages['invalidDiameter'];
    }

    if (!AppConstants.allowedDiameters.contains(diameter)) {
      return 'Diameter must be one of: ${AppConstants.allowedDiameters.join(", ")} inches';
    }

    return null;
  }

  /// Validate thickness level input (1-5)
  ///
  /// Returns error message if invalid, null if valid.
  static String? validateThickness(String? input) {
    if (input == null || input.trim().isEmpty) {
      return AppConstants.errorMessages['emptyThickness'];
    }

    final int? thickness = int.tryParse(input.trim());
    if (thickness == null) {
      return AppConstants.errorMessages['invalidThickness'];
    }

    if (thickness < AppConstants.minThickness || thickness > AppConstants.maxThickness) {
      return 'Thickness must be between ${AppConstants.minThickness} and ${AppConstants.maxThickness}';
    }

    return null;
  }

  /// Validate proving time input (1-48 hours)
  ///
  /// Returns error message if invalid, null if valid.
  static String? validateProvingTime(String? input) {
    if (input == null || input.trim().isEmpty) {
      return AppConstants.errorMessages['emptyProvingTime'];
    }

    final int? hours = int.tryParse(input.trim());
    if (hours == null) {
      return AppConstants.errorMessages['invalidProvingTime'];
    }

    if (hours < AppConstants.minProvingTimeHours || hours > AppConstants.maxProvingTimeHours) {
      return 'Proving time must be between ${AppConstants.minProvingTimeHours} and ${AppConstants.maxProvingTimeHours} hours';
    }

    return null;
  }

  /// Validate number of pizzas input
  ///
  /// Returns error message if invalid, null if valid.
  static String? validateNumberOfPizzas(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Number of pizzas cannot be empty';
    }

    final int? count = int.tryParse(input.trim());
    if (count == null) {
      return 'Number of pizzas must be a whole number';
    }

    if (count <= 0) {
      return 'Number of pizzas must be at least 1';
    }

    if (count > 10) {
      return 'Maximum 10 pizzas supported';
    }

    return null;
  }

  /// Validate all calculator parameters at once
  ///
  /// Returns a map of field names to error messages.
  /// Empty map indicates all fields are valid.
  static Map<String, String> validateAllParameters({
    required String diameter,
    required String thickness,
    required String provingTime,
    required String numberOfPizzas,
  }) {
    final Map<String, String> errors = {};

    final diameterError = validateDiameter(diameter);
    if (diameterError != null) {
      errors['diameter'] = diameterError;
    }

    final thicknessError = validateThickness(thickness);
    if (thicknessError != null) {
      errors['thickness'] = thicknessError;
    }

    final provingTimeError = validateProvingTime(provingTime);
    if (provingTimeError != null) {
      errors['provingTime'] = provingTimeError;
    }

    final numberOfPizzasError = validateNumberOfPizzas(numberOfPizzas);
    if (numberOfPizzasError != null) {
      errors['numberOfPizzas'] = numberOfPizzasError;
    }

    return errors;
  }

  /// Check if a diameter value is supported
  static bool isDiameterSupported(double diameter) {
    return AppConstants.allowedDiameters.contains(diameter);
  }

  /// Check if a thickness level is valid
  static bool isThicknessValid(int thickness) {
    return thickness >= AppConstants.minThickness && 
           thickness <= AppConstants.maxThickness;
  }

  /// Check if a proving time is valid
  static bool isProvingTimeValid(int hours) {
    return hours >= AppConstants.minProvingTimeHours && 
           hours <= AppConstants.maxProvingTimeHours;
  }

  /// Get helpful validation hints for form fields
  static Map<String, String> get validationHints {
    return {
      'diameter': 'Choose from: ${AppConstants.allowedDiameters.join(", ")} inches',
      'thickness': 'Scale 1-5: ${ThicknessLevel.values.map((t) => '${t.value}=${t.displayName}').join(", ")}',
      'provingTime': 'Enter whole hours between ${AppConstants.minProvingTimeHours} and ${AppConstants.maxProvingTimeHours}',
      'numberOfPizzas': 'Enter number between 1 and 10',
    };
  }

  /// Get example valid inputs for testing/documentation
  static Map<String, String> get exampleValidInputs {
    return {
      'diameter': '12',
      'thickness': '3',
      'provingTime': '24',
      'numberOfPizzas': '1',
    };
  }

}