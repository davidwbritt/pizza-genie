/// Pizza Genie Application Enums and Value Objects
/// 
/// This file contains type-safe enums and value objects for the application.

import 'constants.dart';

/// Pizza crust thickness levels with named styles
enum ThicknessLevel {
  veryThin(1, 'Very Thin'),
  nyStyle(2, 'NY Style'),
  neapolitan(3, 'Neapolitan'),
  grandma(4, 'Grandma'),
  sicilian(5, 'Sicilian');

  const ThicknessLevel(this.value, this.displayName);
  
  final int value;
  final String displayName;
  
  /// Get ThicknessLevel from integer value
  static ThicknessLevel fromValue(int value) {
    switch (value) {
      case 1:
        return ThicknessLevel.veryThin;
      case 2:
        return ThicknessLevel.nyStyle;
      case 3:
        return ThicknessLevel.neapolitan;
      case 4:
        return ThicknessLevel.grandma;
      case 5:
        return ThicknessLevel.sicilian;
      default:
        throw ArgumentError('Invalid thickness level: $value. Must be 1-5.');
    }
  }
}

/// Types of pizza dough ingredients
enum IngredientType {
  flour('Flour'),
  water('Water'),
  salt('Salt'),
  yeast('Yeast'),
  sugar('Sugar'),
  oil('Olive Oil');

  const IngredientType(this.displayName);
  
  final String displayName;
}

/// Measurement system preferences
enum MeasurementSystem {
  metric('Metric'),
  imperial('Imperial'),
  dual('Both');

  const MeasurementSystem(this.displayName);
  
  final String displayName;
}

/// Pizza diameter value object with validation
class PizzaDiameter {
  const PizzaDiameter(this.value);
  
  final double value;
  
  /// Create PizzaDiameter with validation
  factory PizzaDiameter.validated(double value) {
    if (!AppConstants.allowedDiameters.contains(value)) {
      throw ArgumentError(
        'Diameter must be one of: ${AppConstants.allowedDiameters}',
      );
    }
    return PizzaDiameter(value);
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaDiameter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '${value.toInt()}"';
}

/// Proving time value object with validation
class ProvingTime {
  const ProvingTime(this.hours);
  
  final int hours;
  
  /// Create ProvingTime with validation
  factory ProvingTime.validated(int hours) {
    if (hours < AppConstants.minProvingTimeHours || 
        hours > AppConstants.maxProvingTimeHours) {
      throw ArgumentError(
        'Proving time must be between ${AppConstants.minProvingTimeHours} '
        'and ${AppConstants.maxProvingTimeHours} hours',
      );
    }
    return ProvingTime(hours);
  }
  
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvingTime &&
          runtimeType == other.runtimeType &&
          hours == other.hours;

  @override
  int get hashCode => hours.hashCode;

  @override
  String toString() => '${hours}h';
}