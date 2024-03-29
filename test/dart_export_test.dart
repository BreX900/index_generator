import 'package:index_generator/src/dart_code/dart_export.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('test DartExport class', () {
    test('Export dart package file', () {
      final export = DartExport(
        package: 'dart:async',
        show: ['Future'],
        hide: ['Stream'],
      );

      expect(export.toCode(), 'export \'dart:async\' show Future hide Stream;');
    });

    test('Export only library', () {
      final export = DartExport(
        package: 'package:example/example.dart',
      );

      expect(export.toCode(), 'export \'package:example/example.dart\';');
    });

    test('Export library and show MyClass', () {
      final export = DartExport(
        package: 'package:example/example.dart',
        show: ['MyClass'],
      );

      expect(export.toCode(), 'export \'package:example/example.dart\' show MyClass;');
    });

    test('Export library and hide myFunction', () {
      final export = DartExport(
        package: 'package:example/example.dart',
        hide: ['myFunction'],
      );

      expect(export.toCode(), 'export \'package:example/example.dart\' hide myFunction;');
    });

    test('Export library and show MyClass and hide myFunction', () {
      final export = DartExport(
        package: 'package:example/example.dart',
        show: ['MyClass'],
        hide: ['myFunction'],
      );

      expect(
          export.toCode(), 'export \'package:example/example.dart\' show MyClass hide myFunction;');
    });

    test('Old support', () {
      final export = DartExport(
        package: 'example/example',
      );

      expect(export.toCode(), 'export \'package:example/example.dart\';');
    });
  });
}
