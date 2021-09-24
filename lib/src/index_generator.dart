import 'dart:io';

import 'package:index_generator/src/settings/filters.dart';
import 'package:index_generator/src/settings/index_settings.dart';
import 'package:index_generator/src/settings/package_settings.dart';
import 'package:path/path.dart' as path;

class IndexGenerator {
  final ProjectSettings project;
  final PackageSettings package;
  final IndexSettings index;
  final File indexFile;
  final List<Directory> folders;

  IndexGenerator._({
    required this.project,
    required this.package,
    required this.index,
    required this.folders,
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
      folders: index.folders.map((dir) {
        return Directory(path.join(index.path, dir.replaceAll('/', path.separator)));
      }).toList(),
      indexFile: File(indexPath),
    );
  }

  /// Find dart files without index file
  Iterable<File> findFiles() {
    return folders.expand((dir) {
      return dir.listSync(recursive: true);
    }).where((file) {
      return file.path.endsWith('.dart') && file.path != indexFile.path;
    }).map((e) {
      return File(e.path);
    });
  }

  /// Filter [files] with [config] and [index] filters
  Iterable<File> filterFiles(Iterable<File> files) {
    final allFilters = [...package.filters, ...index.filters];
    final blackFilters = allFilters.whereType<BlackFilter>();
    final whiteFilters = allFilters.whereType<WhiteFilter>();
    return files.where((file) {
      final filePath = file.path.replaceAll(path.separator, '/');
      return blackFilters.every((f) => f.accept(filePath)) ||
          whiteFilters.any((f) => f.accept(filePath));
    });
  }

  /// Convert dart [files] in index content lines
  Iterable<String> fileToExport(Iterable<FileSystemEntity> files) {
    return files.map((file) {
      final indexPath = indexFile.path;
      final filePath = file.path;
      final importPath = filePath.replaceFirst(path.dirname(indexPath), '');
      return "export '${importPath.replaceFirst(path.separator, '').replaceAll('\\', '/')}';";
    });
  }

  Iterable<String> packageToExport(Iterable<String> exports) {
    return exports.map((export) => "export 'package:$export.dart';");
  }

  /// Generate a index file content
  Iterable<String> generate() {
    final externalExports = packageToExport(index.exports).toList()..sort();
    final internalExports = fileToExport(filterFiles(findFiles())).toList()..sort();

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
