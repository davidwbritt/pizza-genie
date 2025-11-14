/// Validation Service Contract
/// Defines the interface for input validation and error handling
abstract class ValidationService {
  /// Validate pizza diameter input
  /// 
  /// Parameters:
  /// - diameter: Diameter value to validate
  /// 
  /// Returns: ValidationResult with success/error details
  ValidationResult validateDiameter(double diameter);

  /// Validate thickness level input
  /// 
  /// Parameters:
  /// - thicknessLevel: Thickness scale value to validate
  /// 
  /// Returns: ValidationResult with success/error details
  ValidationResult validateThicknessLevel(int thicknessLevel);

  /// Validate proving time input
  /// 
  /// Parameters:
  /// - provingTimeHours: Proving time value to validate
  /// 
  /// Returns: ValidationResult with success/error details
  ValidationResult validateProvingTime(int provingTimeHours);

  /// Validate number of pizzas input
  /// 
  /// Parameters:
  /// - numberOfPizzas: Quantity value to validate
  /// 
  /// Returns: ValidationResult with success/error details
  ValidationResult validateNumberOfPizzas(int numberOfPizzas);

  /// Validate complete calculator parameters
  /// Performs comprehensive validation of all inputs
  /// 
  /// Parameters:
  /// - parameters: CalculatorParameters object to validate
  /// 
  /// Returns: ValidationResult with success/error details
  ValidationResult validateCalculatorParameters(CalculatorParameters parameters);

  /// Get user-friendly error message for validation failure
  /// 
  /// Parameters:
  /// - errorType: Type of validation error
  /// - value: The invalid value that caused the error
  /// 
  /// Returns: Human-readable error message
  String getErrorMessage(ValidationErrorType errorType, dynamic value);

  /// Get contextual guidance message for proving time
  /// Provides helpful information about fermentation effects
  /// 
  /// Parameters:
  /// - provingTimeHours: Current proving time setting
  /// 
  /// Returns: Guidance message about yeast quantity and flavor
  String getProvingTimeGuidance(int provingTimeHours);
}

/// Validation result data structure
class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  final ValidationErrorType? errorType;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.errorType,
  });

  factory ValidationResult.success() => const ValidationResult(isValid: true);
  
  factory ValidationResult.error(ValidationErrorType type, String message) =>
      ValidationResult(
        isValid: false,
        errorType: type,
        errorMessage: message,
      );
}

/// Types of validation errors
enum ValidationErrorType {
  invalidDiameter,
  invalidThickness,
  invalidProvingTime,
  invalidQuantity,
  outOfRange,
  required,
  invalidFormat,
}