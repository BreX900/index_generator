import 'package:index_generator/src/settings/library_settings.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  const projectName = 'project_name';
  const defaultFileName = 'default_file_name';

  group('LibrarySettings', () {
    group('resolveFileName', () {
      test('If fileName exist returns it', () {
        const settings = LibrarySettings(
          directoryPath: '',
          fileName: 'file_name',
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, settings.fileName);
      });

      test('If fileName not exist and dirPath is lib returns projectName', () {
        const settings = LibrarySettings(
          directoryPath: 'lib',
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, projectName);
      });

      test('If fileName not exist and dirPath is not lib returns defaultFileName', () {
        const settings = LibrarySettings(
          directoryPath: 'random',
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, defaultFileName);
      });

      test('If fileName, defaultFileName not exist and dirPath is not lib returns dir name', () {
        const settings = LibrarySettings(
          directoryPath: 'dir_name',
        );

        final actual = settings.resolveFileName(projectName, null);

        expect(actual, 'dir_name');
      });
    });

    group('includeLibrary', () {
      test('defaults to true', () {
        const settings = LibrarySettings(
          directoryPath: 'lib',
        );

        expect(settings.includeLibrary, isTrue);
      });

      test('can be set to false', () {
        const settings = LibrarySettings(
          directoryPath: 'lib',
          includeLibrary: false,
        );

        expect(settings.includeLibrary, isFalse);
      });
    });
  });
}
