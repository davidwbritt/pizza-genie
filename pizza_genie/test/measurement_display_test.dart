import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_genie/models/ingredient_measurement.dart';
import 'package:pizza_genie/constants/enums.dart';

void main() {
  group('Imperial Measurement Display', () {
    test('shows only fraction when imperialNote is provided', () {
      final measurement = IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.salt,
        metricValue: 3.0,
        metricUnit: 'g',
        imperialValue: 0.5,
        imperialUnit: 'tsp',
        imperialNote: '1/2',
      );

      expect(measurement.imperialDisplay, equals('1/2 tsp'));
      expect(measurement.imperialDisplay, isNot(contains('0.5')));
    });

    test('shows decimal when no imperialNote is provided', () {
      final measurement = IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.salt,
        metricValue: 3.0,
        metricUnit: 'g',
        imperialValue: 0.75,
        imperialUnit: 'tsp',
      );

      expect(measurement.imperialDisplay, equals('0.75 tsp'));
      expect(measurement.imperialDisplay, isNot(contains('/')));
    });

    test('shows only fraction for mixed numbers', () {
      final measurement = IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.flour,
        metricValue: 275.0,
        metricUnit: 'g',
        imperialValue: 2.125,
        imperialUnit: 'cups',
        imperialNote: '2 1/8',
      );

      expect(measurement.imperialDisplay, equals('2 1/8 cups'));
      expect(measurement.imperialDisplay, isNot(contains('2.1')));
    });

    test('handles empty imperialNote gracefully', () {
      final measurement = IngredientMeasurement.fromBoth(
        ingredientType: IngredientType.water,
        metricValue: 180.0,
        metricUnit: 'ml',
        imperialValue: 1.5,
        imperialUnit: 'fl oz',
        imperialNote: '',
      );

      expect(measurement.imperialDisplay, equals('1.5 fl oz'));
    });
  });
}