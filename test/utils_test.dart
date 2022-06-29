import 'package:index_generator/src/_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  const tLine = 'Test line';

  group('Utils', () {
    group('parseTextLines', () {
      test('remove first empty lines', () {
        final actual = Utils.parseTextLines('\n\n\n$tLine');

        expect(actual, [tLine]);
      });

      test('clean lines and not remove center lines', () {
        final actual = Utils.parseTextLines('$tLine \n \n$tLine');

        expect(actual, [tLine, '', tLine]);
      });

      test('remove last empty lines', () {
        final actual = Utils.parseTextLines('$tLine\n\n');

        expect(actual, [tLine]);
      });
    });
  });
}
