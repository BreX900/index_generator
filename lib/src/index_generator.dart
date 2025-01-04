import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:index_generator/src/_utils.dart';
import 'package:index_generator/src/dart_code/dart_export.dart';
import 'package:index_generator/src/settings/dart.dart';
import 'package:index_generator/src/settings/library_settings.dart';
import 'package:index_generator/src/settings/package_settings.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';

class IndexGenerator {
  final Pubspec pubspec;
  final AnalysisOptions analysisOptions;
  final PackageSettings package;
  final LibrarySettings library;

  final Directory indexFolder;
  final File indexFile;

  IndexGenerator._({
    required this.pubspec,
    required this.analysisOptions,
    required this.package,
    required this.library,
    required this.indexFolder,
    required this.indexFile,
  });

  factory IndexGenerator.from(
    Pubspec pubspec,
    AnalysisOptions? analysisOptions,
    PackageSettings package,
    LibrarySettings index,
  ) {
    final indexPath = path.join(
      index.directoryPath,
      '${index.resolveFileName(pubspec.name, package.defaultFileName)}.dart',
    );
    return IndexGenerator._(
      pubspec: pubspec,
      analysisOptions: analysisOptions ?? const AnalysisOptions(),
      package: package,
      library: index,
      indexFolder: Directory(index.directoryPath),
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

  /// Filter [files] with [config] and [library] filters
  Iterable<File> filterFiles(Iterable<File> files) {
    final include = [...package.include, ...library.include];
    final exclude = [...package.exclude, ...library.exclude];

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

  Iterable<String> packagesToExports(List<ExportSettings> exports) {
    return exports.map(_packageToExport);
  }

  String _packageToExport(ExportSettings export) {
    return DartExport(
      package: export.package,
      show: export.show,
      hide: export.hide,
    ).toCode();
  }

  /// Generate a index file content
  Iterable<String> generate() {
    final comments = Utils.parseTextLines(library.comments);
    final docs = Utils.parseTextLines(library.docs);

    final externalExports = packagesToExports(library.exports).toList()..sort();

    final internalFiles = findFiles();
    final internalFilteredFiles = filterFiles(internalFiles);
    final internalExports = fileToExport(internalFilteredFiles).toList()..sort();

    final name = library.name;
    return [
      if (library.disclaimer) ...[
        '// GENERATED CODE - DO NOT MODIFY BY HAND',
        '',
      ],
      if (comments.isNotEmpty) ...[
        for (final line in comments) '// $line',
        '',
      ],
      if (docs.isNotEmpty)
        for (final line in docs) '/// $line',
      'library${name != null ? ' $name' : ''};',
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
    final languageVersion = pubspec.environment.sdk as VersionRange;
    final formatter = DartFormatter(
      languageVersion: languageVersion.min!,
      lineEnding: package.lineBreak,
      pageWidth: package.pageWidth ?? analysisOptions.formatter.pageWidth,
    );

    final content = formatter.format(generate().join(package.lineBreak));

    await indexFile.writeAsString(content);
  }
}
