/// Pizza Dough Calculation Formulas
/// 
/// This file contains pizza-specific calculation formulas and conversion factors
/// based on culinary principles without using proprietary recipes.

import '../constants/enums.dart';

/// Pizza dough calculation formulas using baker's percentage
class PizzaFormulas {
  
  // Standard baker's percentages for common ingredients
  static const double saltPercentage = 0.02;    // 2%
  static const double sugarPercentage = 0.015;  // 1.5% 
  static const double oilPercentage = 0.02;     // 2%
  
  /// Get hydration ratio for each pizza style (renamed for API compatibility)
  static double getHydrationRatio(ThicknessLevel thickness) {
    return getHydrationPercentage(thickness);
  }
  
  /// Get hydration percentage for each pizza style
  static double getHydrationPercentage(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin:
        return 0.55; // 55% - Less water for easier handling
      case ThicknessLevel.nyStyle:
        return 0.62; // 62% - Balanced hydration
      case ThicknessLevel.neapolitan:
        return 0.65; // 65% - Higher hydration for light texture
      case ThicknessLevel.grandma:
        return 0.72; // 72% - High hydration for focaccia-like texture
      case ThicknessLevel.sicilian:
        return 0.58; // 58% - Moderate hydration for thick crust
    }
  }
  
  /// Get yeast ratio adjusted for proving time (API compatibility method)
  static double getYeastRatio(ThicknessLevel thickness, int provingTimeHours) {
    final baseYeast = getBaseYeastPercentage(thickness);
    return calculateYeastForProvingTime(
      baseYeastPercentage: baseYeast,
      provingTimeHours: provingTimeHours,
    );
  }
  
  /// Get base yeast percentage (before proving time adjustment)
  static double getBaseYeastPercentage(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin:
        return 0.003; // 0.3% - Low yeast for thin crust
      case ThicknessLevel.nyStyle:
        return 0.005; // 0.5% - Standard yeast level
      case ThicknessLevel.neapolitan:
        return 0.002; // 0.2% - Very low yeast for long fermentation
      case ThicknessLevel.grandma:
        return 0.01; // 1% - Higher yeast for lighter texture
      case ThicknessLevel.sicilian:
        return 0.008; // 0.8% - Moderate yeast for thick crust
    }
  }
  
  /// Calculate yeast percentage adjusted for proving time
  static double calculateYeastForProvingTime({
    required double baseYeastPercentage,
    required int provingTimeHours,
  }) {
    // Inverse relationship: longer proving = less yeast needed
    // Formula: adjusted_yeast = base_yeast * (24 / proving_time)^0.7
    // Capped between 0.1% and 1.5%
    
    const double referencetime = 24.0; // 24 hours as reference
    
    final double timeFactor = (referencetime / provingTimeHours);
    final double adjustedYeast = baseYeastPercentage * 
        (timeFactor < 1.0 ? timeFactor : timeFactor.clamp(0.5, 2.0));
    
    // Clamp to reasonable yeast range
    return adjustedYeast.clamp(0.001, 0.015); // 0.1% to 1.5%
  }
  
  /// Get salt percentage (standard 2-3% of flour weight)
  static double getSaltPercentage(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin:
        return 0.025; // 2.5%
      case ThicknessLevel.nyStyle:
        return 0.02; // 2%
      case ThicknessLevel.neapolitan:
        return 0.025; // 2.5%
      case ThicknessLevel.grandma:
        return 0.02; // 2%
      case ThicknessLevel.sicilian:
        return 0.022; // 2.2%
    }
  }
  
  /// Get sugar percentage (aids yeast activity)
  static double getSugarPercentage(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin:
        return 0.01; // 1%
      case ThicknessLevel.nyStyle:
        return 0.015; // 1.5%
      case ThicknessLevel.neapolitan:
        return 0.005; // 0.5% - minimal sugar for traditional style
      case ThicknessLevel.grandma:
        return 0.02; // 2%
      case ThicknessLevel.sicilian:
        return 0.015; // 1.5%
    }
  }
  
  /// Get oil percentage (varies by style)
  static double getOilPercentage(ThicknessLevel thickness) {
    switch (thickness) {
      case ThicknessLevel.veryThin:
        return 0.01; // 1% - minimal oil
      case ThicknessLevel.nyStyle:
        return 0.02; // 2%
      case ThicknessLevel.neapolitan:
        return 0.005; // 0.5% - traditional style uses little oil
      case ThicknessLevel.grandma:
        return 0.04; // 4% - higher oil content
      case ThicknessLevel.sicilian:
        return 0.03; // 3%
    }
  }
  
  /// Calculate base dough weight needed for pizza size and thickness
  static double calculateDoughWeight({
    required double diameter,
    required ThicknessLevel thickness,
  }) {
    // Base weight calculation: area * thickness factor
    const double pi = 3.14159;
    final double radius = diameter / 2.0;
    final double area = pi * radius * radius;
    
    // Thickness multiplier (grams per square inch)
    double thicknessMultiplier;
    switch (thickness) {
      case ThicknessLevel.veryThin:
        thicknessMultiplier = 3.0; // Very light dough coverage
      case ThicknessLevel.nyStyle:
        thicknessMultiplier = 4.5; // Standard coverage
      case ThicknessLevel.neapolitan:
        thicknessMultiplier = 4.0; // Light but slightly thicker than very thin
      case ThicknessLevel.grandma:
        thicknessMultiplier = 7.0; // Thick, airy dough
      case ThicknessLevel.sicilian:
        thicknessMultiplier = 8.5; // Thickest style
    }
    
    return area * thicknessMultiplier;
  }
}

/// Ingredient conversion factors for measurement display
class IngredientConversions {
  
  /// Conversion factors from grams to imperial measurements
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
  
  /// Liquid conversion factors (for water and oil)
  static const double millilitersPerCup = 240.0;
  static const double millilitersPerTablespoon = 15.0;
  static const double millilitersPerTeaspoon = 5.0;
}

/// Conversion factors for different ingredients
class ConversionFactors {
  const ConversionFactors({
    required this.gramsPerCup,
    required this.gramsPerTablespoon,
    required this.gramsPerTeaspoon,
  });
  
  final double gramsPerCup;
  final double gramsPerTablespoon;
  final double gramsPerTeaspoon;
}