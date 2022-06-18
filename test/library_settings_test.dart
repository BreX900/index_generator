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
          dirPath: '',
          fileName: 'file_name',
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, settings.fileName);
      });

      test('If fileName not exist and dirPath is lib returns projectName', () {
        final settings = LibrarySettings(
          dirPath: 'lib',
          fileName: null,
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, projectName);
      });

      test('If fileName not exist and dirPath is not lib returns defaultFileName', () {
        final settings = LibrarySettings(
          dirPath: 'random',
          fileName: null,
        );

        final actual = settings.resolveFileName(projectName, defaultFileName);

        expect(actual, defaultFileName);
      });

      test('If fileName, defaultFileName not exist and dirPath is not lib returns dir name', () {
        final settings = LibrarySettings(
          dirPath: 'dir_name',
          fileName: null,
        );

        final actual = settings.resolveFileName(projectName, null);

        expect(actual, 'dir_name');
      });
    });

    group('resolveLibraryName', () {
      test('If library name exist returns it', () {
        final settings = LibrarySettings(
          dirPath: '',
          name: 'name',
        );

        final actual = settings.resolveLibraryName(projectName);

        expect(actual, settings.name);
      });

      test('If library name not exist returns fileName', () {
        final settings = LibrarySettings(
          dirPath: 'lib',
          name: null,
          fileName: 'file_name',
        );

        final actual = settings.resolveLibraryName(projectName);

        expect(actual, settings.fileName);
      });

      test('If library name, fileName not exist and dir name is lib returns projectName', () {
        final settings = LibrarySettings(
          dirPath: 'lib',
          name: null,
          fileName: null,
        );

        final actual = settings.resolveLibraryName(projectName);

        expect(actual, projectName);
      });

      test('If library name, fileName not exist and dir name is not lib returns dir name', () {
        final settings = LibrarySettings(
          dirPath: 'dir_name',
          name: null,
          fileName: null,
        );

        final actual = settings.resolveLibraryName(projectName);

        expect(actual, 'dir_name');
      });
    });
  });
}
