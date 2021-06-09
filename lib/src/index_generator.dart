import 'dart:io';

import 'package:index_generator/src/_entities.dart';
import 'package:path/path.dart' as path;

bool isTestingMode = false;

class IndexGenerator {
  final Config config;
  final Index folder;
  final File indexFile;
  final List<Directory> directories;

  IndexGenerator._({
    required this.config,
    required this.folder,
    required this.directories,
    required this.indexFile,
  });

  static String resolveIndexName(Config config, Index folder) {
    if (folder.name != null) {
      return folder.name!;
    } else if (path.basename(folder.path) == 'lib') {
      return config.name;
    } else if (config.defaultName != null) {
      return config.defaultName!;
    } else {
      return path.basename(folder.path);
    }
  }

  factory IndexGenerator.from({required Config config, required Index folder}) {
    final indexPath = path.join(folder.path, '${resolveIndexName(config, folder)}.dart');
    return IndexGenerator._(
      config: config,
      folder: folder,
      directories: folder.folders.map((dir) {
        return Directory(dir.replaceAll('/', path.separator));
      }).toList(),
      indexFile: File(indexPath),
    );
  }

  /// Find dart files without index file
  Iterable<FileSystemEntity> findDartFiles() {
    final files = directories.expand((dir) => dir.listSync(recursive: true));
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
      final filePath = file.path.replaceAll(path.separator, '/');
      return blackFilters.every((f) => f.accept(filePath)) ||
          whiteFilters.any((f) => f.accept(filePath));
    });
  }

  /// Convert dart [files] in index content lines
  Iterable<String> stringify(Iterable<FileSystemEntity> files) {
    return files.map((file) {
      final indexPath = indexFile.path;
      final filePath = file.path;
      final importPath = filePath.replaceFirst(path.dirname(indexPath), '');
      return "export '${importPath.replaceFirst(path.separator, '').replaceAll('\\', '/')}';";
    });
  }

  /// Generate a index file content
  Iterable<String> generate() {
    final allFiles = findDartFiles();
    final files = applyFilters(allFiles).toList();
    files.sort((p, c) => p.path.compareTo(c.path));
    final lines = stringify(files);
    return [
      '// GENERATED CODE - DO NOT MODIFY BY HAND',
      '',
      if (folder.canUseLibrary ?? config.canUseLibrary) ...[
        'library ${folder.library ?? path.basename(folder.path)};',
        '',
      ],
      ...lines,
    ];
  }

  /// Create a index file content
  void create() {
    indexFile.writeAsStringSync(generate().join('\n'));
  }
}
