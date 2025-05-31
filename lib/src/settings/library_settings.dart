import 'package:glob/glob.dart';
import 'package:index_generator/index_generator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:path/path.dart' as p;

part 'library_settings.g.dart';

@DataClass()
@JsonSerializable()
@GlobJsonConverter()
class LibrarySettings with _$LibrarySettings {
  /// Folder path to create a index file
  final String directoryPath;

  /// File name with extension
  final String? fileName;

  /// Adds the generated code disclaimer
  final bool disclaimer;

  /// Include library keyword in generated file
  final bool includeLibrary;

  /// Library comments (copyright)
  final String comments;

  /// Library documentation
  final String docs;

  /// Library name
  final String? name;

  /// List of export packages
  final List<ExportSettings> exports;

  /// White filters
  final List<Glob> include;

  /// Black filters
  final List<Glob> exclude;

  const LibrarySettings({
    required this.directoryPath,
    this.fileName,
    this.disclaimer = true,
    this.includeLibrary = true,
    this.comments = '',
    this.docs = '',
    this.name,
    this.exports = const <ExportSettings>[],
    this.include = const <Glob>[],
    this.exclude = const <Glob>[],
  });

  String resolveFileName(String projectName, String? defaultFileName) {
    final fileName = this.fileName;
    if (fileName != null) return fileName;

    final dirName = p.basename(directoryPath);
    if (dirName == 'lib') return projectName;

    if (defaultFileName != null) return defaultFileName;

    return dirName;
  }

  factory LibrarySettings.fromJson(Map map) => _$LibrarySettingsFromJson(map);
}

@DataClass()
@JsonSerializable()
class ExportSettings with _$ExportSettings {
  /// Package name without dart extension
  final String package;

  /// Class o method to show
  final List<String> show;

  /// Class o method to hide
  final List<String> hide;

  const ExportSettings({
    required this.package,
    this.show = const [],
    this.hide = const [],
  });

  factory ExportSettings.fromJson(Map data) => _$ExportSettingsFromJson(data);
}
