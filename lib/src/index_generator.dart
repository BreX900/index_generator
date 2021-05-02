import 'dart:io';

import 'package:index_generator/src/_entities.dart';
import 'package:path/path.dart';

bool isTestingMode = false;

class IndexGenerator {
  final Config config;
  final Folder folder;
  final Directory indexDirectory;
  final File indexFile;

  IndexGenerator._({
    required this.config,
    required this.folder,
    required this.indexDirectory,
    required this.indexFile,
  });

  static String resolveIndexName(Config config, Folder folder) {
    if (folder.indexName != null) {
      return folder.indexName!;
    } else if (context.basename(folder.path) == 'lib') {
      return config.name;
    } else if (config.indexName != null) {
      return config.indexName!;
    } else {
      return context.basename(folder.path);
    }
  }

  factory IndexGenerator.from({required Config config, required Folder folder}) {
    final indexPath = context.join(folder.path, '${resolveIndexName(config, folder)}.dart');
    return IndexGenerator._(
      config: config,
      folder: folder,
      indexDirectory: Directory(folder.path),
      indexFile: File(indexPath),
    );
  }

  /// Find dart files without index file
  Iterable<FileSystemEntity> findDartFiles() {
    final files = indexDirectory.listSync(recursive: true);
    return files.where((file) {
      return file.path.endsWith('.dart') && file.path != indexFile.path;
    });
  }

  /// Filter [files] with [config] and [folder] filters
  Iterable<FileSystemEntity> applyFilters(Iterable<FileSystemEntity> files) {
    final allFilters = [...config.filters, ...folder.filters];
    final blackFilters = allFilters.whereType<BlackFilter>();
    final whiteFilters = allFilters.whereType<WhiteFilter>();
    return files.where((file) {
      final path = file.path.replaceAll(context.separator, '/');
      return blackFilters.every((f) => f.accept(path)) || whiteFilters.any((f) => f.accept(path));
    });
  }

  /// Convert dart [files] in index content lines
  Iterable<String> stringify(Iterable<FileSystemEntity> files) {
    return files.map((file) {
      return "export '${file.path.replaceAll('${indexDirectory.path}${context.separator}', '').replaceAll('\\', '/')}';";
    });
  }

  /// Generate a index file content
  Iterable<String> generate() {
    final allFiles = findDartFiles();
    final files = applyFilters(allFiles).toList();
    files.sort((p, c) => p.path.compareTo(c.path));
    final lines = stringify(files);
    if (folder.canUseLibrary ?? config.canUseLibrary) {
      return [
        '// GENERATED CODE - DO NOT MODIFY BY HAND',
        '',
        'library ${folder.library ?? context.basename(folder.path)};',
        '',
        ...lines,
      ];
    } else {
      return lines;
    }
  }

  /// Create a index file content
  void create() {
    indexFile.writeAsStringSync(generate().join('\n'));
  }
}
