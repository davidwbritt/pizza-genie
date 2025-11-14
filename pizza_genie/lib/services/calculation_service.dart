import '../models/calculator_parameters.dart';
import '../models/pizza_dough_recipe.dart';
import '../models/ingredient_measurement.dart';
import '../utils/pizza_formulas.dart';
import '../utils/measurement_converter.dart';
import '../constants/enums.dart';

/// Core service for calculating pizza dough recipes
///
/// This service combines pizza formulas, measurement conversion, and
/// business logic to generate complete dough recipes from user parameters.
class CalculationService {
  /// Calculate a complete pizza dough recipe from user parameters
  ///
  /// Returns a PizzaDoughRecipe with all ingredient quantities calculated
  /// based on the pizza diameter, thickness, and proving time.
  static PizzaDoughRecipe calculateRecipe(CalculatorParameters parameters) {
    // Calculate base dough weight for the pizza(s)
    final double totalDoughWeight = PizzaFormulas.calculateDoughWeight(
      diameter: parameters.diameter.value,
      thickness: parameters.thicknessLevel,
    ) * parameters.numberOfPizzas;

    // Get style-specific ratios
    final double hydrationRatio = PizzaFormulas.getHydrationRatio(
      parameters.thicknessLevel,
    );
    
    final double yeastRatio = PizzaFormulas.getYeastRatio(
      parameters.thicknessLevel,
      parameters.provingTimeHours.hours,
    );

    // Calculate flour as the base (100%)
    final double flourWeight = _calculateFlourWeight(
      totalDoughWeight,
      hydrationRatio,
      yeastRatio,
    );

    // Calculate all ingredients using baker's percentages
    final double waterWeight = flourWeight * hydrationRatio;
    final double saltWeight = flourWeight * PizzaFormulas.saltPercentage;
    final double yeastWeight = flourWeight * yeastRatio;
    final double sugarWeight = flourWeight * PizzaFormulas.sugarPercentage;
    final double oilWeight = flourWeight * PizzaFormulas.oilPercentage;

    return PizzaDoughRecipe(
      flourGrams: flourWeight,
      waterMilliliters: waterWeight, // 1g = 1ml for water
      saltGrams: saltWeight,
      yeastGrams: yeastWeight,
      sugarGrams: sugarWeight,
      oilGrams: oilWeight,
      calculatedFor: parameters,
    );
  }

  /// Calculate recipe with dual measurement display
  ///
  /// Returns a recipe along with all ingredients converted to 
  /// dual metric/imperial measurements for user display.
  static RecipeWithMeasurements calculateRecipeWithMeasurements(
    CalculatorParameters parameters,
  ) {
    final recipe = calculateRecipe(parameters);
    
    final measurements = MeasurementConverter.convertRecipeIngredients(
      flourGrams: recipe.flourGrams,
      waterMl: recipe.waterMilliliters,
      saltGrams: recipe.saltGrams,
      yeastGrams: recipe.yeastGrams,
      sugarGrams: recipe.sugarGrams,
      oilGrams: recipe.oilGrams,
    );

    return RecipeWithMeasurements(
      recipe: recipe,
      measurements: measurements,
    );
  }

  /// Calculate flour weight needed for target total dough weight
  ///
  /// Uses baker's percentages to work backwards from total weight
  /// to find the flour amount that will produce the desired total.
  static double _calculateFlourWeight(
    double targetTotalWeight,
    double hydrationRatio,
    double yeastRatio,
  ) {
    // Total percentage = flour(100%) + water + salt + yeast + sugar + oil
    final double totalPercentage = 1.0 + // flour (100%)
        hydrationRatio +
        PizzaFormulas.saltPercentage +
        yeastRatio +
        PizzaFormulas.sugarPercentage +
        PizzaFormulas.oilPercentage;

    // Flour weight = target total / total percentage
    return targetTotalWeight / totalPercentage;
  }

  /// Calculate scaling factor for making multiple pizzas
  ///
  /// Returns the multiplier needed to scale a single pizza recipe
  /// for the requested number of pizzas.
  static double calculateScalingFactor(int numberOfPizzas) {
    return numberOfPizzas.toDouble();
  }

  /// Estimate total preparation and proving time
  ///
  /// Returns estimated total time in minutes including mixing,
  /// kneading, and proving based on the proving time selected.
  static int estimateTotalTimeMinutes(CalculatorParameters parameters) {
    const int mixingTimeMinutes = 15;
    const int kneadingTimeMinutes = 10;
    const int shapingTimeMinutes = 5;
    
    final int provingTimeMinutes = parameters.provingTimeHours.hours * 60;
    
    return mixingTimeMinutes + kneadingTimeMinutes + shapingTimeMinutes + provingTimeMinutes;
  }

  /// Get preparation steps for the calculated recipe
  ///
  /// Returns a list of step descriptions for making the dough
  /// based on the proving time and technique.
  static List<String> getPreparationSteps(CalculatorParameters parameters) {
    final bool isLongProve = parameters.provingTimeHours.hours >= 12;
    
    final List<String> steps = [
      'Measure all ingredients using a kitchen scale',
      'Mix flour and salt in a large bowl',
      'Dissolve yeast and sugar in lukewarm water (100-110°F)',
      'Add water mixture and oil to flour',
      'Mix until a shaggy dough forms',
      'Knead for 8-10 minutes until smooth and elastic',
    ];

    if (isLongProve) {
      steps.addAll([
        'Shape into a ball and place in oiled container',
        'Cover and refrigerate for ${parameters.provingTimeHours.hours} hours',
        'Remove from fridge 30 minutes before shaping',
      ]);
    } else {
      steps.addAll([
        'Shape into a ball and place in oiled bowl',
        'Cover and let rise in warm place for ${parameters.provingTimeHours.hours} hour${parameters.provingTimeHours.hours > 1 ? 's' : ''}',
        'Dough is ready when doubled in size',
      ]);
    }

    steps.addAll([
      'Divide into ${parameters.numberOfPizzas} portion${parameters.numberOfPizzas > 1 ? 's' : ''}',
      'Shape into pizza bases and add toppings',
    ]);

    return steps;
  }

  /// Validate that calculation parameters will produce reasonable results
  ///
  /// Returns validation errors if the parameters would result in
  /// impractical quantities or cooking difficulties.
  static List<String> validateCalculationParameters(CalculatorParameters parameters) {
    final List<String> warnings = [];
    
    // Check for very small yeast amounts
    final recipe = calculateRecipe(parameters);
    if (recipe.yeastGrams < 0.1) {
      warnings.add('Very small yeast amount - consider using instant yeast for accuracy');
    }

    // Check for very long proving times with high yeast
    if (parameters.provingTimeHours.hours >= 24 && recipe.yeastGrams > 2.0) {
      warnings.add('Long proving time with high yeast may cause over-fermentation');
    }

    // Check for very thick pizzas with short proving
    if (parameters.thicknessLevel.value >= 4 && parameters.provingTimeHours.hours < 4) {
      warnings.add('Thick crusts benefit from longer proving times for better texture');
    }

    return warnings;
  }
}

/// Container for recipe with converted measurements
class RecipeWithMeasurements {
  const RecipeWithMeasurements({
    required this.recipe,
    required this.measurements,
  });

  final PizzaDoughRecipe recipe;
  final List<IngredientMeasurement> measurements;

  /// Get ingredient measurement by type
  IngredientMeasurement getMeasurement(IngredientType type) {
    return measurements.firstWhere(
      (m) => m.ingredientType == type,
      orElse: () => throw ArgumentError('Ingredient type not found: $type'),
    );
  }

  /// Get all measurements formatted for display
  List<String> get formattedMeasurements {
    return measurements.map((m) => m.fullDisplay).toList();
  }
}