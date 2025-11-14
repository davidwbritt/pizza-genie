import '../constants/enums.dart';
import '../models/ingredient_measurement.dart';

/// Utility service for converting between metric and imperial measurements
///
/// This service handles conversions for all pizza dough ingredients,
/// providing user-friendly imperial equivalents for metric quantities.
class MeasurementConverter {
  // Imperial conversion constants
  static const double gramsPerOz = 28.3495;
  static const double mlPerFlOz = 29.5735;
  static const double mlPerCup = 236.588;
  static const double mlPerTbsp = 14.7868;
  static const double mlPerTsp = 4.92892;
  static const double gramsPerCup = 125.0; // For flour (varies by ingredient)

  /// Convert metric ingredient quantities to dual measurement format
  ///
  /// Returns an IngredientMeasurement with both metric and imperial values.
  static IngredientMeasurement convertIngredient({
    required IngredientType ingredient,
    required double metricValue,
  }) {
    switch (ingredient) {
      case IngredientType.flour:
        return _convertFlour(metricValue);
      case IngredientType.water:
        return _convertWater(metricValue);
      case IngredientType.salt:
        return _convertSalt(metricValue);
      case IngredientType.yeast:
        return _convertYeast(metricValue);
      case IngredientType.sugar:
        return _convertSugar(metricValue);
      case IngredientType.oil:
        return _convertOil(metricValue);
    }
  }

  /// Convert flour from grams to cups/ounces
  static IngredientMeasurement _convertFlour(double grams) {
    final cups = grams / gramsPerCup;
    
    if (cups >= 0.25) {
      final rounded = _roundToStandardFraction(cups);
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.flour,
        metricValue: grams,
        metricUnit: 'g',
        imperialValue: rounded.value,
        imperialUnit: rounded.value >= 1.5 ? 'cups' : 'cup',
        imperialNote: rounded.fraction,
      );
    } else {
      final ounces = grams / gramsPerOz;
      final rounded = _roundToStandardFraction(ounces);
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.flour,
        metricValue: grams,
        metricUnit: 'g',
        imperialValue: rounded.value,
        imperialUnit: 'oz',
        imperialNote: rounded.fraction,
      );
    }
  }

  /// Convert water from milliliters to cups/fluid ounces
  static IngredientMeasurement _convertWater(double ml) {
    final cups = ml / mlPerCup;
    
    if (cups >= 0.25) {
      final rounded = _roundToStandardFraction(cups);
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.water,
        metricValue: ml,
        metricUnit: 'ml',
        imperialValue: rounded.value,
        imperialUnit: rounded.value >= 1.5 ? 'cups' : 'cup',
        imperialNote: rounded.fraction,
      );
    } else {
      final flOz = ml / mlPerFlOz;
      final rounded = _roundToStandardFraction(flOz);
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.water,
        metricValue: ml,
        metricUnit: 'ml',
        imperialValue: rounded.value,
        imperialUnit: 'fl oz',
        imperialNote: rounded.fraction,
      );
    }
  }

  /// Convert salt from grams to teaspoons
  static IngredientMeasurement _convertSalt(double grams) {
    // Salt density: approximately 6g per teaspoon
    const gramsPerTsp = 6.0;
    final teaspoons = grams / gramsPerTsp;
    final rounded = _roundToStandardFraction(teaspoons);
    
    if (rounded.value < 0.125) {
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.salt,
        metricValue: grams,
        metricUnit: 'g',
        imperialValue: 1.0,
        imperialUnit: 'pinch',
      );
    } else {
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.salt,
        metricValue: grams,
        metricUnit: 'g',
        imperialValue: rounded.value,
        imperialUnit: rounded.value == 1.0 ? 'tsp' : 'tsp',
        imperialNote: rounded.fraction,
      );
    }
  }

  /// Convert yeast from grams to teaspoons
  static IngredientMeasurement _convertYeast(double grams) {
    // Active dry yeast: approximately 4g per teaspoon
    const gramsPerTsp = 4.0;
    final teaspoons = grams / gramsPerTsp;
    final rounded = _roundToStandardFraction(teaspoons);
    
    return IngredientMeasurement.fromBoth(
      ingredientType: IngredientType.yeast,
      metricValue: grams,
      metricUnit: 'g',
      imperialValue: rounded.value,
      imperialUnit: 'tsp',
      imperialNote: rounded.fraction,
    );
  }

  /// Convert sugar from grams to teaspoons
  static IngredientMeasurement _convertSugar(double grams) {
    // Granulated sugar: approximately 4g per teaspoon
    const gramsPerTsp = 4.0;
    final teaspoons = grams / gramsPerTsp;
    final rounded = _roundToStandardFraction(teaspoons);
    
    return IngredientMeasurement.fromBoth(
      ingredientType: IngredientType.sugar,
      metricValue: grams,
      metricUnit: 'g',
      imperialValue: rounded.value,
      imperialUnit: 'tsp',
      imperialNote: rounded.fraction,
    );
  }

  /// Convert olive oil from grams to tablespoons/teaspoons
  static IngredientMeasurement _convertOil(double grams) {
    // Olive oil density: approximately 0.915 g/ml
    const oilDensity = 0.915;
    final ml = grams / oilDensity;
    final tablespoons = ml / mlPerTbsp;
    
    if (tablespoons >= 1.0) {
      final rounded = _roundToStandardFraction(tablespoons);
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.oil,
        metricValue: grams,
        metricUnit: 'g',
        imperialValue: rounded.value,
        imperialUnit: 'tbsp',
        imperialNote: rounded.fraction,
      );
    } else {
      final teaspoons = ml / mlPerTsp;
      final rounded = _roundToStandardFraction(teaspoons);
      return IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.oil,
        metricValue: grams,
        metricUnit: 'g',
        imperialValue: rounded.value,
        imperialUnit: 'tsp',
        imperialNote: rounded.fraction,
      );
    }
  }

  /// Get complex imperial breakdown for precise measurements
  ///
  /// Useful for ingredients like flour where users might want
  /// "1 cup 2 tbsp" instead of "1.125 cups".
  static ImperialMeasurement getComplexImperialMeasurement({
    required IngredientType ingredient,
    required double metricValue,
  }) {
    switch (ingredient) {
      case IngredientType.flour:
        return _getComplexFlourMeasurement(metricValue);
      case IngredientType.water:
        return _getComplexWaterMeasurement(metricValue);
      default:
        // For other ingredients, return simple measurement
        final simple = convertIngredient(
          ingredient: ingredient, 
          metricValue: metricValue,
        );
        return ImperialMeasurement(
          cups: 0,
          tablespoons: 0,
          teaspoons: simple.imperialValue,
          displayText: simple.imperialDisplay,
        );
    }
  }

  /// Get complex flour measurement breakdown
  static ImperialMeasurement _getComplexFlourMeasurement(double grams) {
    final totalCups = grams / gramsPerCup;
    
    final wholeCups = totalCups.floor().toDouble();
    final remainingCups = totalCups - wholeCups;
    
    // Convert remaining to tablespoons
    final remainingGrams = remainingCups * gramsPerCup;
    final gramsPerTbspFlour = gramsPerCup / 16; // 16 tbsp per cup
    final tablespoons = remainingGrams / gramsPerTbspFlour;
    
    final wholeTablespoons = tablespoons.floor().toDouble();
    
    // Build display text
    final List<String> parts = [];
    if (wholeCups >= 1) {
      parts.add('${wholeCups.toStringAsFixed(0)} cup${wholeCups > 1 ? 's' : ''}');
    }
    if (wholeTablespoons >= 1) {
      parts.add('${wholeTablespoons.toStringAsFixed(0)} tbsp');
    }
    
    final displayText = parts.isEmpty ? '${tablespoons.toStringAsFixed(1)} tbsp' : parts.join(' ');
    
    return ImperialMeasurement(
      cups: wholeCups,
      tablespoons: wholeTablespoons,
      teaspoons: 0,
      displayText: displayText,
    );
  }

  /// Get complex water measurement breakdown
  static ImperialMeasurement _getComplexWaterMeasurement(double ml) {
    final totalCups = ml / mlPerCup;
    
    final wholeCups = totalCups.floor().toDouble();
    final remainingCups = totalCups - wholeCups;
    
    // Convert remaining to tablespoons
    final remainingMl = remainingCups * mlPerCup;
    final tablespoons = remainingMl / mlPerTbsp;
    
    final wholeTablespoons = tablespoons.floor().toDouble();
    
    // Build display text
    final List<String> parts = [];
    if (wholeCups >= 1) {
      parts.add('${wholeCups.toStringAsFixed(0)} cup${wholeCups > 1 ? 's' : ''}');
    }
    if (wholeTablespoons >= 1) {
      parts.add('${wholeTablespoons.toStringAsFixed(0)} tbsp');
    }
    
    final displayText = parts.isEmpty ? '${tablespoons.toStringAsFixed(1)} tbsp' : parts.join(' ');
    
    return ImperialMeasurement(
      cups: wholeCups,
      tablespoons: wholeTablespoons,
      teaspoons: 0,
      displayText: displayText,
    );
  }

  /// Convert all ingredients in a recipe to dual measurements
  static List<IngredientMeasurement> convertRecipeIngredients({
    required double flourGrams,
    required double waterMl,
    required double saltGrams,
    required double yeastGrams,
    required double sugarGrams,
    required double oilGrams,
  }) {
    return [
      convertIngredient(ingredient: IngredientType.flour, metricValue: flourGrams),
      convertIngredient(ingredient: IngredientType.water, metricValue: waterMl),
      convertIngredient(ingredient: IngredientType.salt, metricValue: saltGrams),
      convertIngredient(ingredient: IngredientType.yeast, metricValue: yeastGrams),
      convertIngredient(ingredient: IngredientType.sugar, metricValue: sugarGrams),
      convertIngredient(ingredient: IngredientType.oil, metricValue: oilGrams),
    ];
  }

  /// Round to standard kitchen fractions (1/4, 1/2, 3/4, etc.)
  static StandardFraction _roundToStandardFraction(double value) {
    // Define standard kitchen fractions
    const fractions = [
      FractionPair(1/8, '1/8'),
      FractionPair(1/4, '1/4'),
      FractionPair(1/3, '1/3'),
      FractionPair(1/2, '1/2'),
      FractionPair(2/3, '2/3'),
      FractionPair(3/4, '3/4'),
      FractionPair(1.0, ''),
    ];

    // For values >= 1, handle whole numbers + fractions
    if (value >= 1.0) {
      final wholeNumber = value.floor();
      final fractionalPart = value - wholeNumber;
      
      if (fractionalPart < 0.0625) {
        // Round down to whole number
        return StandardFraction(wholeNumber.toDouble(), wholeNumber > 1 ? '$wholeNumber' : '');
      }
      
      // Find closest standard fraction for the fractional part
      FractionPair closest = fractions.first;
      double minDiff = (fractionalPart - closest.value).abs();
      
      for (final fraction in fractions) {
        final diff = (fractionalPart - fraction.value).abs();
        if (diff < minDiff) {
          minDiff = diff;
          closest = fraction;
        }
      }
      
      if (closest.value == 1.0) {
        // Round up to next whole number
        return StandardFraction((wholeNumber + 1).toDouble(), '');
      } else {
        // Combine whole number with fraction
        final displayText = wholeNumber > 0 ? '$wholeNumber ${closest.text}' : closest.text;
        return StandardFraction(wholeNumber + closest.value, displayText);
      }
    } else {
      // For values < 1, just find the closest standard fraction
      if (value < 0.0625) {
        return StandardFraction(0.125, '1/8'); // Minimum measurable amount
      }
      
      FractionPair closest = fractions.first;
      double minDiff = (value - closest.value).abs();
      
      for (final fraction in fractions) {
        final diff = (value - fraction.value).abs();
        if (diff < minDiff) {
          minDiff = diff;
          closest = fraction;
        }
      }
      
      return StandardFraction(closest.value, closest.text);
    }
  }
}

/// Helper class for standard kitchen fractions
class StandardFraction {
  const StandardFraction(this.value, this.fraction);
  final double value;
  final String fraction;
}

/// Helper class for fraction mapping
class FractionPair {
  const FractionPair(this.value, this.text);
  final double value;
  final String text;
}