/// Preference Service Contract
/// Defines the interface for user preference persistence
abstract class PreferenceService {
  /// Save user theme preference
  /// 
  /// Parameters:
  /// - themeMode: ThemeMode enum (light, dark, system)
  /// 
  /// Returns: Future<bool> indicating success
  Future<bool> saveThemePreference(ThemeMode themeMode);

  /// Load user theme preference
  /// 
  /// Returns: Future<ThemeMode> - saved preference or system default
  Future<ThemeMode> loadThemePreference();

  /// Save user's preferred measurement system
  /// 
  /// Parameters:
  /// - system: MeasurementSystem enum (metric, imperial, dual)
  /// 
  /// Returns: Future<bool> indicating success
  Future<bool> saveMeasurementPreference(MeasurementSystem system);

  /// Load user's measurement preference
  /// 
  /// Returns: Future<MeasurementSystem> - saved preference or dual default
  Future<MeasurementSystem> loadMeasurementPreference();

  /// Save last used calculator parameters (optional)
  /// Allows users to resume previous calculation state
  /// 
  /// Parameters:
  /// - parameters: CalculatorParameters object to persist
  /// 
  /// Returns: Future<bool> indicating success
  Future<bool> saveLastCalculatorParameters(CalculatorParameters parameters);

  /// Load last used calculator parameters
  /// 
  /// Returns: Future<CalculatorParameters?> - saved parameters or null
  Future<CalculatorParameters?> loadLastCalculatorParameters();

  /// Clear all saved preferences
  /// Used for reset/logout functionality
  /// 
  /// Returns: Future<bool> indicating success
  Future<bool> clearAllPreferences();

  /// Check if this is first app launch
  /// Used to determine if onboarding should be shown
  /// 
  /// Returns: Future<bool> - true if first launch
  Future<bool> isFirstLaunch();

  /// Mark app as launched (no longer first time)
  /// 
  /// Returns: Future<bool> indicating success
  Future<bool> markAsLaunched();
}