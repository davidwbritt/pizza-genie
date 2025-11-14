import '../constants/enums.dart';

/// Dual measurement display for ingredients (metric + imperial)
/// 
/// This model represents an ingredient quantity in both metric and imperial
/// units for display purposes, supporting users with and without kitchen scales.
class IngredientMeasurement {
  const IngredientMeasurement({
    required this.ingredientType,
    required this.metricValue,
    required this.metricUnit,
    required this.imperialValue,
    required this.imperialUnit,
    this.imperialNote,
  });

  /// Type of ingredient for context
  final IngredientType ingredientType;
  
  /// Value in metric units (grams/ml)
  final double metricValue;
  
  /// Metric unit label ("g", "ml")
  final String metricUnit;
  
  /// Value in imperial units
  final double imperialValue;
  
  /// Imperial unit label ("cups", "tsp", "tbsp", "oz")
  final String imperialUnit;
  
  /// Optional note for imperial measurement (e.g., "heaping", "level")
  final String? imperialNote;

  /// Get formatted metric display string
  String get metricDisplay {
    return '${_formatValue(metricValue)}$metricUnit';
  }

  /// Get formatted imperial display string
  String get imperialDisplay {
    final baseDisplay = '${_formatValue(imperialValue)} $imperialUnit';
    return imperialNote != null ? '$imperialNote $baseDisplay' : baseDisplay;
  }

  /// Get combined dual display string
  String get dualDisplay {
    return '$metricDisplay ($imperialDisplay)';
  }

  /// Get ingredient name with measurements
  String get fullDisplay {
    return '${ingredientType.displayName}: $dualDisplay';
  }

  /// Format numeric value for display
  String _formatValue(double value) {
    if (value < 0.1) {
      return value.toStringAsFixed(2);
    } else if (value < 1.0) {
      return value.toStringAsFixed(2);
    } else if (value < 10.0) {
      return value.toStringAsFixed(1);
    } else {
      return value.toStringAsFixed(0);
    }
  }

  /// Create measurement with both metric and imperial values
  factory IngredientMeasurement.fromBoth({
    required IngredientType ingredientType,
    required double metricValue,
    required String metricUnit,
    required double imperialValue,
    required String imperialUnit,
    String? imperialNote,
  }) {
    return IngredientMeasurement(
      ingredientType: ingredientType,
      metricValue: metricValue,
      metricUnit: metricUnit,
      imperialValue: imperialValue,
      imperialUnit: imperialUnit,
      imperialNote: imperialNote,
    );
  }

  /// Create a copy with modified values
  IngredientMeasurement copyWith({
    IngredientType? ingredientType,
    double? metricValue,
    String? metricUnit,
    double? imperialValue,
    String? imperialUnit,
    String? imperialNote,
  }) {
    return IngredientMeasurement(
      ingredientType: ingredientType ?? this.ingredientType,
      metricValue: metricValue ?? this.metricValue,
      metricUnit: metricUnit ?? this.metricUnit,
      imperialValue: imperialValue ?? this.imperialValue,
      imperialUnit: imperialUnit ?? this.imperialUnit,
      imperialNote: imperialNote ?? this.imperialNote,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientMeasurement &&
          runtimeType == other.runtimeType &&
          ingredientType == other.ingredientType &&
          metricValue == other.metricValue &&
          metricUnit == other.metricUnit &&
          imperialValue == other.imperialValue &&
          imperialUnit == other.imperialUnit &&
          imperialNote == other.imperialNote;

  @override
  int get hashCode =>
      ingredientType.hashCode ^
      metricValue.hashCode ^
      metricUnit.hashCode ^
      imperialValue.hashCode ^
      imperialUnit.hashCode ^
      imperialNote.hashCode;

  @override
  String toString() {
    return fullDisplay;
  }
}

/// Imperial measurement breakdown for complex conversions
class ImperialMeasurement {
  const ImperialMeasurement({
    required this.cups,
    required this.tablespoons,
    required this.teaspoons,
    required this.displayText,
  });

  /// Cups portion of the measurement
  final double cups;
  
  /// Tablespoons portion of the measurement  
  final double tablespoons;
  
  /// Teaspoons portion of the measurement
  final double teaspoons;
  
  /// Pre-formatted display text (e.g., "1 cup 2 tbsp")
  final String displayText;

  /// Check if measurement is primarily in cups
  bool get isCupMeasurement => cups >= 0.25;
  
  /// Check if measurement is primarily in tablespoons
  bool get isTablespoonMeasurement => tablespoons >= 0.5 && cups < 0.25;
  
  /// Check if measurement is primarily in teaspoons
  bool get isTeaspoonMeasurement => teaspoons > 0 && tablespoons < 0.5;

  @override
  String toString() => displayText;
}