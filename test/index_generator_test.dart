import 'package:index_generator/src/_entities.dart';
import 'package:index_generator/src/index_generator.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      final generator = IndexGenerator.from(
        config: Config(name: 'index_generator'),
        folder: Folder(path: 'lib'),
      );

    });
  });
}
