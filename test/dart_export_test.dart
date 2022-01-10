import 'package:index_generator/src/dart_code/dart_export.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('test DartExport class', () {
    test('Export only library', () {
      final export = DartExport(
        library: 'package:example/example.dart',
      );

      expect(export.toCode(), 'export \'package:example/example.dart\';');
    });

    test('Export library and show MyClass', () {
      final export = DartExport(
        library: 'package:example/example.dart',
        show: ['MyClass'],
      );

      expect(export.toCode(),
          'export \'package:example/example.dart\' show MyClass;');
    });

    test('Export library and hide myFunction', () {
      final export = DartExport(
        library: 'package:example/example.dart',
        hide: ['myFunction'],
      );

      expect(export.toCode(),
          'export \'package:example/example.dart\' hide myFunction;');
    });

    test('Export library and show MyClass and hide myFunction', () {
      final export = DartExport(
        library: 'package:example/example.dart',
        show: ['MyClass'],
        hide: ['myFunction'],
      );

      expect(export.toCode(),
          'export \'package:example/example.dart\' show MyClass hide myFunction;');
    });

    test('Old support', () {
      final export = DartExport(
        library: 'example/example',
      );

      expect(export.toCode(), 'export \'package:example/example.dart\';');
    });
  });
}
