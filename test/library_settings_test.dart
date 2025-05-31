import 'package:index_generator/src/settings/library_settings.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final projectName = 'project_name';
  final defaultFileName = 'default_file_name';

  group('LibrarySettings', () {
    group('resolveFileName', () {
      test('If fileName exist returns it', () {
        final settings = LibrarySettings(
          directoryPath: '',
          fileName: 'file_name',
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, settings.fileName);
      });

      test('If fileName not exist and dirPath is lib returns projectName', () {
        final settings = LibrarySettings(
          directoryPath: 'lib',
          fileName: null,
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, projectName);
      });

      test('If fileName not exist and dirPath is not lib returns defaultFileName', () {
        final settings = LibrarySettings(
          directoryPath: 'random',
          fileName: null,
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, defaultFileName);
      });

      test('If fileName, defaultFileName not exist and dirPath is not lib returns dir name', () {
        final settings = LibrarySettings(
          directoryPath: 'dir_name',
          fileName: null,
        );

        final actual = settings.resolveFileName(projectName, null);

        expect(actual, 'dir_name');
      });
    });

    group('includeLibrary', () {
      test('defaults to true', () {
        final settings = LibrarySettings(
          directoryPath: 'lib',
        );

        expect(settings.includeLibrary, isTrue);
      });

      test('can be set to false', () {
        final settings = LibrarySettings(
          directoryPath: 'lib',
          includeLibrary: false,
        );

        expect(settings.includeLibrary, isFalse);
      });
    });
  });
}
