/// Measurement Converter Contract  
/// Defines the interface for dual metric/imperial unit conversions
abstract class MeasurementConverter {
  /// Convert ingredient measurement to dual display format
  /// Each ingredient has specific conversion ratios for accuracy
  /// 
  /// Parameters:
  /// - ingredientType: Type of ingredient (flour, water, salt, etc.)
  /// - metricValue: Value in metric units (grams or ml)
  /// 
  /// Returns: IngredientMeasurement with both metric and imperial values
  IngredientMeasurement convertToDualDisplay({
    required IngredientType ingredientType,
    required double metricValue,
  });

  /// Convert grams to volume measurements for dry ingredients
  /// Different ingredients have different densities
  /// 
  /// Parameters:
  /// - ingredientType: Type of dry ingredient
  /// - grams: Weight in grams
  /// 
  /// Returns: ImperialMeasurement with cups/tablespoons/teaspoons
  ImperialMeasurement gramsToVolume({
    required IngredientType ingredientType,
    required double grams,
  });

  /// Convert milliliters to imperial volume measurements
  /// 
  /// Parameters:
  /// - milliliters: Volume in ml
  /// 
  /// Returns: ImperialMeasurement with cups/tablespoons/teaspoons
  ImperialMeasurement millilitersToImperial(double milliliters);

  /// Format measurement value for display
  /// Handles decimal places and appropriate precision
  /// 
  /// Parameters:
  /// - value: Numeric value to format
  /// - unit: Unit type for formatting rules
  /// 
  /// Returns: Formatted string with appropriate decimal places
  String formatMeasurement(double value, String unit);

  /// Get ingredient-specific conversion factors
  /// 
  /// Parameters:
  /// - ingredientType: Type of ingredient
  /// 
  /// Returns: ConversionFactors object with density and volume ratios
  ConversionFactors getConversionFactors(IngredientType ingredientType);
}

/// Imperial measurement breakdown
class ImperialMeasurement {
  final double cups;
  final double tablespoons;
  final double teaspoons;
  final String displayText;

  const ImperialMeasurement({
    required this.cups,
    required this.tablespoons,
    required this.teaspoons,
    required this.displayText,
  });
}

/// Conversion factors for different ingredients
class ConversionFactors {
  final double gramsPerCup;      // Density for volume conversion
  final double gramsPerTablespoon;
  final double gramsPerTeaspoon;
  
  const ConversionFactors({
    required this.gramsPerCup,
    required this.gramsPerTablespoon,
    required this.gramsPerTeaspoon,
  });
}

/// Standard conversion factors by ingredient type
class IngredientConversions {
  static const Map<IngredientType, ConversionFactors> factors = {
    IngredientType.flour: ConversionFactors(
      gramsPerCup: 120.0,      // All-purpose flour
      gramsPerTablespoon: 7.5,
      gramsPerTeaspoon: 2.5,
    ),
    IngredientType.salt: ConversionFactors(
      gramsPerCup: 300.0,      // Table salt
      gramsPerTablespoon: 18.0,
      gramsPerTeaspoon: 6.0,
    ),
    IngredientType.yeast: ConversionFactors(
      gramsPerCup: 128.0,      // Active dry yeast
      gramsPerTablespoon: 8.0,
      gramsPerTeaspoon: 2.7,
    ),
    IngredientType.sugar: ConversionFactors(
      gramsPerCup: 200.0,      // Granulated sugar
      gramsPerTablespoon: 12.5,
      gramsPerTeaspoon: 4.2,
    ),
    IngredientType.oil: ConversionFactors(
      gramsPerCup: 220.0,      // Olive oil (density ~0.92 g/ml)
      gramsPerTablespoon: 13.5,
      gramsPerTeaspoon: 4.5,
    ),
  };
}