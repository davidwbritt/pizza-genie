# Pizza Genie Quickstart Guide

**Last Updated**: 2024-11-14  
**Target**: Developers implementing Pizza Genie mobile application

## Prerequisites

- **Flutter SDK**: 3.10.0 or higher
- **Dart SDK**: 3.0.0 or higher  
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (API level 21+ for target deployment)
- **Git** for version control

## Project Setup

### 1. Create Flutter Project

```bash
flutter create pizza_genie
cd pizza_genie
```

### 2. Update pubspec.yaml Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1          # State management
  shared_preferences: ^2.2.2 # Local storage
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  mockito: ^5.4.2            # Testing mocks
  build_runner: ^2.4.7       # Code generation
```

### 3. Project Structure Setup

Create the following directory structure in `lib/`:

```bash
mkdir -p lib/{constants,models,services,screens,widgets,utils}
mkdir -p test/{unit/{models,services,utils},widget,integration}
```

## Core Implementation Order

### Phase 1: Data Models (Day 1)
1. **Create base models**:
   ```bash
   # lib/models/
   touch calculator_parameters.dart
   touch pizza_dough_recipe.dart  
   touch user_preferences.dart
   touch ingredient_measurement.dart
   ```

2. **Implement enums and value objects**:
   ```bash
   # lib/constants/
   touch constants.dart          # App constants per requirement
   touch pizza_constants.dart    # Pizza-specific constants
   ```

### Phase 2: Services (Day 2-3)
1. **Core calculation service**:
   ```bash
   # lib/services/
   touch calculation_service.dart
   touch preference_service.dart
   touch validation_service.dart
   ```

2. **Utility services**:
   ```bash
   # lib/utils/  
   touch measurement_converter.dart
   touch pizza_formulas.dart
   ```

### Phase 3: UI Layer (Day 4-5)
1. **State management setup**:
   ```bash
   # lib/providers/ (create directory)
   touch calculator_provider.dart
   touch theme_provider.dart
   ```

2. **Screen implementation**:
   ```bash
   # lib/screens/
   touch main_screen.dart        # Calculator screen
   touch settings_screen.dart    # Theme selection
   touch about_screen.dart       # App information
   touch privacy_screen.dart     # Privacy policy
   ```

3. **Reusable widgets**:
   ```bash
   # lib/widgets/
   touch calculator_form.dart    # Input form
   touch ingredient_display.dart # Results display
   touch theme_selector.dart     # Theme toggle widget
   ```

## Key Implementation Guidelines

### Calculator Service Implementation
```dart
// lib/services/calculation_service.dart
class DoughCalculationService implements CalculationService {
  @override
  PizzaDoughRecipe calculateDoughRecipe({
    required double diameter,
    required int thicknessLevel, 
    required int provingTimeHours,
    int numberOfPizzas = 1,
  }) {
    // 1. Validate inputs using ValidationService
    // 2. Calculate base dough weight from diameter + thickness
    // 3. Apply style-specific hydration ratios
    // 4. Adjust yeast for proving time
    // 5. Scale for number of pizzas
    // 6. Return PizzaDoughRecipe object
  }
}
```

### Theme Management Pattern
```dart
// lib/providers/theme_provider.dart  
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final PreferenceService _prefs;

  ThemeMode get themeMode => _themeMode;

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await _prefs.saveThemePreference(_themeMode);
    notifyListeners();
  }
}
```

### Input Validation Pattern
```dart
// lib/widgets/calculator_form.dart
TextFormField(
  keyboardType: TextInputType.number,
  validator: (value) => _validationService.validateProvingTime(
    int.tryParse(value ?? '') ?? 0
  ).errorMessage,
  onChanged: (value) => _updateProvingTimeGuidance(value),
)
```

## Testing Strategy

### 1. Unit Tests First
```bash
# test/unit/services/
flutter test test/unit/services/calculation_service_test.dart
```

### 2. Widget Tests  
```bash
# test/widget/
flutter test test/widget/calculator_form_test.dart
```

### 3. Integration Tests
```bash
# integration_test/
flutter drive --target=integration_test/app_test.dart
```

## Development Workflow

### Daily Development Cycle
1. **Morning**: Write failing tests for today's target feature
2. **Implementation**: Code to make tests pass
3. **Integration**: Connect with existing components
4. **Testing**: Run full test suite
5. **Review**: Check against functional requirements

### Key Milestones
- **Day 1**: Data models complete, basic tests passing
- **Day 3**: Calculator service working with test coverage
- **Day 5**: UI complete with theme switching functional  
- **Day 7**: Full integration testing and edge case handling

## Quick Commands

```bash
# Run all tests
flutter test

# Run specific test file  
flutter test test/unit/services/calculation_service_test.dart

# Build for Android
flutter build apk

# Run in debug mode
flutter run

# Analyze code quality
flutter analyze

# Format code
dart format .
```

## Common Patterns

### Error Handling
```dart
// Consistent error handling across services
try {
  final result = await service.calculate(parameters);
  return Success(result);
} catch (e) {
  return Failure(ValidationError(e.message));
}
```

### State Management
```dart
// Provider pattern for state changes
Consumer<CalculatorProvider>(
  builder: (context, calculator, child) {
    return calculator.isLoading 
        ? CircularProgressIndicator()
        : IngredientDisplay(recipe: calculator.recipe);
  },
)
```

This quickstart provides the foundation for implementing the Pizza Genie application following Flutter best practices while meeting all functional requirements.