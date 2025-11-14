# Research: Pizza Genie Flutter Implementation

**Date**: 2024-11-14  
**Feature**: Pizza Genie Application  
**Purpose**: Research Flutter development approaches and pizza calculation formulas

## Flutter State Management Decision

**Decision**: Provider pattern with SharedPreferences for persistence  
**Rationale**: Provider is officially backed by Flutter team, provides excellent balance of simplicity and functionality for calculator apps with user preferences. Mature ecosystem, extensive documentation, and suitable for single-user apps with moderate state complexity.  
**Alternatives considered**: 
- Riverpod (more complex, compile-time safety not critical for calculator)
- GetX (powerful but adds learning curve)
- BLoC (overkill for this app scope)

## Input Validation Strategy

**Decision**: Form widget with custom validators and input formatters  
**Rationale**: Flutter's built-in Form validation provides user-friendly error display and prevents invalid submissions. TextInputFormatter handles UI-level restrictions while validators provide business logic validation.  
**Alternatives considered**:
- Manual validation (less user-friendly error display)
- Third-party validation packages (unnecessary complexity)

## Dual Measurement Display Approach

**Decision**: Custom conversion utilities with side-by-side display  
**Rationale**: Pizza measurements require specific conversion ratios (grams to cups varies by ingredient). Custom implementation ensures accuracy and allows ingredient-specific conversions while maintaining simple UI.  
**Alternatives considered**:
- units_converter package (generic conversions, not ingredient-specific)
- Single unit with toggle (requires user action to see alternative)

## Pizza Calculation Formulas

**Decision**: Baker's percentage system with style-specific hydration ratios  
**Rationale**: Industry-standard approach using established culinary principles. Avoids proprietary recipes while providing authentic results. Easily adjustable for proving time variations.

### Hydration Ratios by Style:
- **Very Thin (1)**: 55-60% hydration, 0.1-0.5% yeast
- **NY Style (2)**: 60-63% hydration, 0.5-1% yeast  
- **Neapolitan (3)**: 65-70% hydration, 0.1-0.5% yeast
- **Grandma (4)**: 70%+ hydration, 1-1.5% yeast
- **Sicilian (5)**: 55-60% hydration, 1-1.5% yeast

### Base Formula (flour = 100%):
- Salt: 2-3%
- Oil: 2-5% (style dependent)
- Sugar: 1-2% (for yeast activity)
- Yeast: Inverse relationship to proving time (longer time = less yeast)

**Alternatives considered**:
- Fixed ratios (doesn't accommodate style differences)
- Volume-based calculations (less accurate than weight)

## Theme System Implementation

**Decision**: Manual ThemeProvider with SharedPreferences persistence  
**Rationale**: Provides complete control over theme switching, simple to implement, and integrates seamlessly with Provider state management. Avoids external dependencies for basic functionality.  
**Alternatives considered**:
- adaptive_theme package (additional dependency for simple use case)
- System theme only (doesn't meet user control requirement)

## Testing Strategy

**Decision**: Three-tier testing approach (unit/widget/integration)  
**Rationale**: Calculator accuracy is critical - unit tests verify calculation logic, widget tests ensure UI validation works, integration tests validate complete user workflows.

### Testing Focus Areas:
- **Unit**: Calculation formulas, input validation, unit conversions
- **Widget**: Form validation UI, theme switching, input components  
- **Integration**: Complete calculation workflow, preference persistence

**Alternatives considered**:
- Unit tests only (insufficient UI coverage)
- Manual testing only (not scalable, error-prone)