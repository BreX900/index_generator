import 'dart:io';

import 'package:index_generator/src/settings/index_settings.dart';
import 'package:index_generator/src/settings/package_settings.dart';
import 'package:path/path.dart' as path;

class IndexGenerator {
  final ProjectSettings project;
  final PackageSettings package;
  final IndexSettings index;

  final Directory indexFolder;
  final File indexFile;

  IndexGenerator._({
    required this.project,
    required this.package,
    required this.index,
    required this.indexFolder,
    required this.indexFile,
  });

  static String _resolveIndexName(
    ProjectSettings project,
    PackageSettings package,
    IndexSettings index,
  ) {
    if (index.name != null) {
      return index.name!;
    } else if (path.basename(index.path) == 'lib') {
      return project.name;
    } else if (package.defaultName != null) {
      return package.defaultName!;
    } else {
      return path.basename(index.path);
    }
  }

  factory IndexGenerator.from(
    ProjectSettings project,
    PackageSettings package,
    IndexSettings index,
  ) {
    final indexPath = path.join(index.path, '${_resolveIndexName(project, package, index)}.dart');
    return IndexGenerator._(
      project: project,
      package: package,
      index: index,
      indexFolder: Directory(index.path),
      indexFile: File(indexPath),
    );
  }

  /// Find dart files without index file
  Iterable<File> findFiles() {
    return indexFolder.listSync(recursive: true).where((file) {
      return file.path.endsWith('.dart') && file.path != indexFile.path;
    }).map((e) {
      return File(e.path);
    });
  }

  String getRelativeUnixPath(File file) {
    final filePath = file.path.replaceFirst(indexFolder.path, '');
    var unixFilePath = filePath.replaceAll(path.separator, '/');

    if (unixFilePath.startsWith('./')) {
      unixFilePath = unixFilePath.substring(2);
    } else if (unixFilePath.startsWith('/')) {
      unixFilePath = unixFilePath.substring(1);
    }
    return unixFilePath;
  }

  /// Filter [files] with [config] and [index] filters
  Iterable<File> filterFiles(Iterable<File> files) {
    final include = [...package.include, ...index.include];
    final exclude = [...package.exclude, ...index.exclude];

    return files.where((file) {
      final filePath = getRelativeUnixPath(file);

      final isIncluded = include.isEmpty || include.any((f) => f.matches(filePath));
      if (!isIncluded) return false;

      final isExcluded = exclude.any((f) => f.matches(filePath));
      return !isExcluded;
    });
  }

  /// Convert dart [files] in index content lines
  Iterable<String> fileToExport(Iterable<File> files) {
    return files.map((file) {
      final filePath = getRelativeUnixPath(file);

      return "export '$filePath';";
    });
  }

  Iterable<String> packageToExport(List<ExportSettings> exports) {
    return exports.map((export) {
      var str = "export 'package:${export.package}.dart'";
      if (export.show.isNotEmpty) {
        str += ' show ${export.show.join(', ')}';
      }
      if (export.hide.isNotEmpty) {
        str += ' hide ${export.hide.join(', ')}';
      }
      return "$str;";
    });
  }

  /// Generate a index file content
  Iterable<String> generate() {
    final externalExports = packageToExport(index.exports).toList()..sort();

    final internalFiles = findFiles();
    final internalFilteredFiles = filterFiles(internalFiles);
    final internalExports = fileToExport(internalFilteredFiles).toList()..sort();

    return [
      '// GENERATED CODE - DO NOT MODIFY BY HAND',
      '',
      'library ${index.library ?? index.name ?? path.basename(index.path)};',
      '',
      if (externalExports.isNotEmpty) ...[
        ...externalExports,
        '',
      ],
      ...internalExports,
      '',
    ];
  }

  /// Create a index file content
  Future<void> create() async {
    await indexFile.writeAsString(generate().join(package.lineBreak));
  }
}
