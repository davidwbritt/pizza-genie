/// Calculation Service Contract
/// Defines the interface for pizza dough calculations
abstract class CalculationService {
  /// Calculate pizza dough recipe based on input parameters
  /// 
  /// Parameters:
  /// - diameter: Pizza diameter in inches (10, 12, 14, 16)
  /// - thicknessLevel: Crust thickness scale 1-5
  /// - provingTimeHours: Fermentation time 1-48 hours
  /// - numberOfPizzas: Quantity of pizzas (default: 1)
  /// 
  /// Returns: PizzaDoughRecipe with calculated ingredient quantities
  /// 
  /// Throws: ArgumentError if parameters are invalid
  PizzaDoughRecipe calculateDoughRecipe({
    required double diameter,
    required int thicknessLevel,
    required int provingTimeHours,
    int numberOfPizzas = 1,
  });

  /// Calculate yeast quantity based on proving time
  /// Longer proving time requires less yeast for proper fermentation
  /// 
  /// Parameters:
  /// - baseYeastPercentage: Starting yeast percentage for style
  /// - provingTimeHours: Desired fermentation time
  /// 
  /// Returns: Adjusted yeast percentage (0.1% to 1.5% range)
  double calculateYeastForProvingTime({
    required double baseYeastPercentage,
    required int provingTimeHours,
  });

  /// Get hydration percentage for pizza style
  /// Different styles require different water-to-flour ratios
  /// 
  /// Parameters:
  /// - thicknessLevel: Pizza style (1-5 scale)
  /// 
  /// Returns: Hydration percentage (55-70% range)
  double getHydrationForStyle(int thicknessLevel);

  /// Calculate base dough weight for pizza size
  /// Determines total dough needed based on diameter and thickness
  /// 
  /// Parameters:
  /// - diameter: Pizza diameter in inches
  /// - thicknessLevel: Thickness scale (1-5)
  /// 
  /// Returns: Total dough weight in grams
  double calculateDoughWeight({
    required double diameter,
    required int thicknessLevel,
  });
}