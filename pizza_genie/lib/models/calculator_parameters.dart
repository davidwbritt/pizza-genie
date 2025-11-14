import '../constants/enums.dart';
import '../constants/constants.dart';

/// Input parameters for pizza dough calculation
/// 
/// This model represents all the user inputs needed to calculate 
/// a pizza dough recipe, with built-in validation.
class CalculatorParameters {
  const CalculatorParameters({
    required this.diameter,
    required this.thicknessLevel,
    required this.provingTimeHours,
    this.numberOfPizzas = AppConstants.defaultNumberOfPizzas,
  });

  /// Pizza diameter in inches (10, 12, 14, 16)
  final PizzaDiameter diameter;
  
  /// Crust thickness scale 1-5 with named pizza styles
  final ThicknessLevel thicknessLevel;
  
  /// Fermentation time in whole hours (1-48)
  final ProvingTime provingTimeHours;
  
  /// Number of pizzas to make (default: 1)
  final int numberOfPizzas;

  /// Create CalculatorParameters with validation
  factory CalculatorParameters.validated({
    required double diameter,
    required int thicknessLevel,
    required int provingTimeHours,
    int numberOfPizzas = AppConstants.defaultNumberOfPizzas,
  }) {
    // Validate inputs
    final validatedDiameter = PizzaDiameter.validated(diameter);
    final validatedThickness = ThicknessLevel.fromValue(thicknessLevel);
    final validatedProvingTime = ProvingTime.validated(provingTimeHours);
    
    if (numberOfPizzas <= 0) {
      throw ArgumentError('Number of pizzas must be positive');
    }
    
    return CalculatorParameters(
      diameter: validatedDiameter,
      thicknessLevel: validatedThickness,
      provingTimeHours: validatedProvingTime,
      numberOfPizzas: numberOfPizzas,
    );
  }

  /// Create default parameters for initial app state
  factory CalculatorParameters.defaults() {
    return CalculatorParameters(
      diameter: PizzaDiameter(AppConstants.defaultDiameter),
      thicknessLevel: ThicknessLevel.fromValue(AppConstants.defaultThicknessLevel),
      provingTimeHours: ProvingTime(AppConstants.defaultProvingTimeHours),
      numberOfPizzas: AppConstants.defaultNumberOfPizzas,
    );
  }

  /// Create a copy with modified parameters
  CalculatorParameters copyWith({
    PizzaDiameter? diameter,
    ThicknessLevel? thicknessLevel,
    ProvingTime? provingTimeHours,
    int? numberOfPizzas,
  }) {
    return CalculatorParameters(
      diameter: diameter ?? this.diameter,
      thicknessLevel: thicknessLevel ?? this.thicknessLevel,
      provingTimeHours: provingTimeHours ?? this.provingTimeHours,
      numberOfPizzas: numberOfPizzas ?? this.numberOfPizzas,
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'diameter': diameter.value,
      'thicknessLevel': thicknessLevel.value,
      'provingTimeHours': provingTimeHours.hours,
      'numberOfPizzas': numberOfPizzas,
    };
  }

  /// Create from JSON for persistence
  factory CalculatorParameters.fromJson(Map<String, dynamic> json) {
    return CalculatorParameters.validated(
      diameter: (json['diameter'] as num).toDouble(),
      thicknessLevel: json['thicknessLevel'] as int,
      provingTimeHours: json['provingTimeHours'] as int,
      numberOfPizzas: json['numberOfPizzas'] as int,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatorParameters &&
          runtimeType == other.runtimeType &&
          diameter == other.diameter &&
          thicknessLevel == other.thicknessLevel &&
          provingTimeHours == other.provingTimeHours &&
          numberOfPizzas == other.numberOfPizzas;

  @override
  int get hashCode =>
      diameter.hashCode ^
      thicknessLevel.hashCode ^
      provingTimeHours.hashCode ^
      numberOfPizzas.hashCode;

  @override
  String toString() {
    return 'CalculatorParameters{'
        'diameter: $diameter, '
        'thickness: ${thicknessLevel.displayName}, '
        'provingTime: $provingTimeHours, '
        'numberOfPizzas: $numberOfPizzas'
        '}';
  }
}