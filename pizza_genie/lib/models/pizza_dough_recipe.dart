import 'calculator_parameters.dart';
import '../constants/enums.dart';

/// Calculated pizza dough recipe with ingredient quantities
/// 
/// This model represents the output of the dough calculation service,
/// containing all ingredient quantities in grams/ml.
class PizzaDoughRecipe {
  const PizzaDoughRecipe({
    required this.flourGrams,
    required this.waterMilliliters,
    required this.saltGrams,
    required this.yeastGrams,
    required this.sugarGrams,
    required this.oilGrams,
    required this.calculatedFor,
  });

  /// Flour quantity in grams (base ingredient = 100%)
  final double flourGrams;
  
  /// Water quantity in milliliters
  final double waterMilliliters;
  
  /// Salt quantity in grams
  final double saltGrams;
  
  /// Yeast quantity in grams (adjusted for proving time)
  final double yeastGrams;
  
  /// Sugar quantity in grams (aids yeast activity)
  final double sugarGrams;
  
  /// Olive oil quantity in grams
  final double oilGrams;
  
  /// Input parameters used for this calculation
  final CalculatorParameters calculatedFor;

  /// Get all ingredients as a list for easy iteration
  List<IngredientQuantity> get ingredients {
    return [
      IngredientQuantity(
        type: IngredientType.flour,
        quantity: flourGrams,
        unit: 'g',
      ),
      IngredientQuantity(
        type: IngredientType.water,
        quantity: waterMilliliters,
        unit: 'ml',
      ),
      IngredientQuantity(
        type: IngredientType.salt,
        quantity: saltGrams,
        unit: 'g',
      ),
      IngredientQuantity(
        type: IngredientType.yeast,
        quantity: yeastGrams,
        unit: 'g',
      ),
      IngredientQuantity(
        type: IngredientType.sugar,
        quantity: sugarGrams,
        unit: 'g',
      ),
      IngredientQuantity(
        type: IngredientType.oil,
        quantity: oilGrams,
        unit: 'g',
      ),
    ];
  }

  /// Get total dough weight in grams
  double get totalDoughWeight {
    return flourGrams + waterMilliliters + saltGrams + 
           yeastGrams + sugarGrams + oilGrams;
  }

  /// Get hydration percentage (water/flour ratio)
  double get hydrationPercentage {
    return (waterMilliliters / flourGrams) * 100;
  }


  /// Get pizza style description
  String get pizzaStyleDescription {
    return calculatedFor.thicknessLevel.displayName;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaDoughRecipe &&
          runtimeType == other.runtimeType &&
          flourGrams == other.flourGrams &&
          waterMilliliters == other.waterMilliliters &&
          saltGrams == other.saltGrams &&
          yeastGrams == other.yeastGrams &&
          sugarGrams == other.sugarGrams &&
          oilGrams == other.oilGrams &&
          calculatedFor == other.calculatedFor;

  @override
  int get hashCode =>
      flourGrams.hashCode ^
      waterMilliliters.hashCode ^
      saltGrams.hashCode ^
      yeastGrams.hashCode ^
      sugarGrams.hashCode ^
      oilGrams.hashCode ^
      calculatedFor.hashCode;

  @override
  String toString() {
    return 'PizzaDoughRecipe{'
        'flour: ${flourGrams.toStringAsFixed(1)}g, '
        'water: ${waterMilliliters.toStringAsFixed(1)}ml, '
        'salt: ${saltGrams.toStringAsFixed(1)}g, '
        'yeast: ${yeastGrams.toStringAsFixed(2)}g, '
        'sugar: ${sugarGrams.toStringAsFixed(1)}g, '
        'oil: ${oilGrams.toStringAsFixed(1)}g, '
        'total: ${totalDoughWeight.toStringAsFixed(1)}g'
        '}';
  }
}

/// Individual ingredient quantity for display purposes
class IngredientQuantity {
  const IngredientQuantity({
    required this.type,
    required this.quantity,
    required this.unit,
  });

  final IngredientType type;
  final double quantity;
  final String unit;

  /// Format quantity for display with appropriate decimal places
  String get formattedQuantity {
    // Show more precision for small quantities (like yeast)
    if (quantity < 1.0) {
      return quantity.toStringAsFixed(2);
    } else if (quantity < 10.0) {
      return quantity.toStringAsFixed(1);
    } else {
      return quantity.toStringAsFixed(0);
    }
  }

  /// Display string for UI
  String get displayString {
    return '$formattedQuantity$unit ${type.displayName}';
  }

  @override
  String toString() {
    return displayString;
  }
}