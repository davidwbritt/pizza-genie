/// Clevermonkey Pizza Genie Application Constants
/// 
/// This file contains app-wide constants as required by the implementation plan.

class AppConstants {
  // App Information
  static const String appName = 'Clevermonkey Pizza Genie';
  static const String appShortName = 'Pizza Genie';
  static const String appDescription = 'A smart dough calculator for home pizza chefs';
  
  // Pizza Diameter Options (inches)
  static const List<double> allowedDiameters = [10.0, 12.0, 14.0, 16.0];
  
  // Thickness Scale Range
  static const int minThickness = 1;
  static const int maxThickness = 5;
  static const int minThicknessLevel = 1;
  static const int maxThicknessLevel = 5;
  
  // Proving Time Range (hours)
  static const int minProvingTimeHours = 2;
  static const int maxProvingTimeHours = 48;
  
  // Default Values
  static const double defaultDiameter = 12.0;
  static const int defaultThicknessLevel = 3; // Neapolitan
  static const int defaultProvingTimeHours = 24;
  static const int defaultNumberOfPizzas = 1;
  
  // Performance Targets
  static const int calculationTimeoutSeconds = 2;
  static const int appLaunchTimeoutSeconds = 30;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 2.0;
  
  // SharedPreferences Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyMeasurementSystem = 'measurement_system';
  static const String keyLastCalculatorParameters = 'last_calculator_parameters';
  static const String keyIsFirstLaunch = 'is_first_launch';
  
  static const Map<String, String> prefsKeys = {
    'themeMode': keyThemeMode,
    'measurementSystem': keyMeasurementSystem,
    'lastParameters': keyLastCalculatorParameters,
    'isFirstLaunch': keyIsFirstLaunch,
  };
  
  // Error Messages
  static const String errorInvalidDiameter = 'Diameter must be 10, 12, 14, or 16 inches';
  static const String errorInvalidThickness = 'Thickness level must be between 1 and 5';
  static const String errorInvalidProvingTime = 'Proving time must be between 1 and 48 hours';
  static const String errorInvalidQuantity = 'Number of pizzas must be a positive number';
  static const String errorCalculationFailed = 'Unable to calculate recipe. Please check your inputs.';
  
  static const Map<String, String> errorMessages = {
    'emptyDiameter': 'Diameter cannot be empty',
    'invalidDiameter': errorInvalidDiameter,
    'emptyThickness': 'Thickness cannot be empty', 
    'invalidThickness': errorInvalidThickness,
    'emptyProvingTime': 'Proving time cannot be empty',
    'invalidProvingTime': errorInvalidProvingTime,
  };
  
}

/// Pizza Style Names
class PizzaStyles {
  static const String veryThin = 'Very Thin';
  static const String nyStyle = 'NY Style';
  static const String neapolitan = 'Neapolitan';
  static const String grandma = 'Grandma';
  static const String sicilian = 'Sicilian';
  
  static const Map<int, String> styleNames = {
    1: veryThin,
    2: nyStyle,
    3: neapolitan,
    4: grandma,
    5: sicilian,
  };
}

/// Measurement Unit Labels
class MeasurementUnits {
  static const String grams = 'g';
  static const String milliliters = 'ml';
  static const String cups = 'cups';
  static const String tablespoons = 'tbsp';
  static const String teaspoons = 'tsp';
  static const String ounces = 'oz';
}