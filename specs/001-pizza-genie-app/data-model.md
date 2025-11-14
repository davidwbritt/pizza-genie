# Data Model: Pizza Genie Application

**Date**: 2024-11-14  
**Feature**: Pizza Genie Application  
**Purpose**: Define data structures and relationships for pizza dough calculation

## Core Entities

### Calculator Parameters
Input parameters for dough calculation.

**Fields**:
- `diameter: double` - Pizza diameter in inches (10, 12, 14, 16)
- `thicknessLevel: int` - Crust thickness scale 1-5 (1=very thin, 2=NY style, 3=Neapolitan, 4=Grandma, 5=Sicilian)  
- `provingTimeHours: int` - Fermentation time in whole hours (1-48)
- `numberOfPizzas: int` - Quantity of pizzas to make (default: 1)

**Validation Rules**:
- Diameter must be exactly 10, 12, 14, or 16 inches
- Thickness level must be 1, 2, 3, 4, or 5
- Proving time must be between 1 and 48 hours inclusive
- Number of pizzas must be positive integer

**State Transitions**: Immutable value object, validated on creation

### Pizza Dough Recipe
Calculated ingredient quantities for pizza dough.

**Fields**:
- `flourGrams: double` - Flour quantity in grams
- `waterMilliliters: double` - Water quantity in ml
- `saltGrams: double` - Salt quantity in grams  
- `yeastGrams: double` - Yeast quantity in grams
- `sugarGrams: double` - Sugar quantity in grams
- `oilGrams: double` - Olive oil quantity in grams
- `calculatedFor: CalculatorParameters` - Input parameters used for calculation

**Relationships**: 
- One-to-one relationship with CalculatorParameters
- Derived/calculated entity based on input parameters

### Ingredient Measurement
Dual display measurement for ingredients.

**Fields**:
- `metricValue: double` - Value in metric units (grams/ml)
- `metricUnit: String` - Metric unit label ("g", "ml")
- `imperialValue: double` - Value in imperial units  
- `imperialUnit: String` - Imperial unit label ("cups", "tsp", "tbsp")
- `ingredientType: IngredientType` - Type of ingredient for conversion accuracy

**Validation Rules**:
- Metric and imperial values must be positive
- Unit labels must match ingredient type conversion rules

### User Preferences
Persistent user settings and preferences.

**Fields**:
- `themeMode: ThemeMode` - Light, dark, or system theme preference
- `preferredUnits: MeasurementSystem` - Primary unit display preference (metric/imperial)
- `lastUsedParameters: CalculatorParameters?` - Optional saved calculator state

**Relationships**: 
- Optional one-to-one with CalculatorParameters for session persistence

**State Transitions**:
- Theme changes trigger immediate UI update and persistence
- Parameter saves are optional user action

### App Information
Static application metadata and content.

**Fields**:
- `version: String` - Application version number
- `buildNumber: String` - Build identifier
- `description: String` - App purpose description
- `privacyPolicyText: String` - Privacy policy content
- `aboutText: String` - About page content

**Validation Rules**: Read-only static content, no user modifications

## Supporting Types

### Enumerations

```dart
enum ThicknessLevel {
  veryThin(1, "Very Thin"),
  nyStyle(2, "NY Style"), 
  neapolitan(3, "Neapolitan"),
  grandma(4, "Grandma"),
  sicilian(5, "Sicilian");
  
  const ThicknessLevel(this.value, this.displayName);
  final int value;
  final String displayName;
}

enum IngredientType {
  flour, water, salt, yeast, sugar, oil
}

enum MeasurementSystem {
  metric, imperial, dual
}
```

### Value Objects

```dart
class PizzaDiameter {
  static const allowedValues = [10.0, 12.0, 14.0, 16.0];
  final double value;
  
  PizzaDiameter(this.value) {
    if (!allowedValues.contains(value)) {
      throw ArgumentError('Diameter must be one of: $allowedValues');
    }
  }
}
```

## Data Flow

1. **Input**: User enters CalculatorParameters via UI forms
2. **Validation**: Parameters validated against business rules  
3. **Calculation**: CalculatorParameters → DoughCalculationService → PizzaDoughRecipe
4. **Display**: PizzaDoughRecipe → IngredientMeasurement list → Dual unit display
5. **Persistence**: UserPreferences saved to local storage via SharedPreferences

## Key Relationships

- **CalculatorParameters** ↔ **PizzaDoughRecipe**: One-to-one calculation relationship
- **PizzaDoughRecipe** → **IngredientMeasurement[]**: One-to-many display relationship  
- **UserPreferences** ↔ **CalculatorParameters**: Optional persistence relationship
- **AppInformation**: Standalone entity with static content

## Persistence Strategy

- **UserPreferences**: Persisted to SharedPreferences as JSON
- **CalculatorParameters**: Optional session persistence only
- **PizzaDoughRecipe**: Calculated on-demand, not persisted
- **AppInformation**: Compiled into application, no persistence needed