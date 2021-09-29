import 'package:glob/glob.dart';
import 'package:index_generator/index_generator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'index_settings.g.dart';

@JsonSerializable()
@GlobJsonConverter()
class IndexSettings implements Stringify {
  /// Folder path to create a index file
  final String path;

  /// File name with extension
  final String? name;

  /// Library name
  final Object? library;

  /// List of export packages
  final List<ExportSettings> exports;

  /// White filters
  final List<Glob> include;

  /// Black filters
  final List<Glob> exclude;

  const IndexSettings({
    required this.path,
    this.name,
    this.library,
    this.exports = const <ExportSettings>[],
    this.include = const <Glob>[],
    this.exclude = const <Glob>[],
  });

  String resolveLibraryName(String folderName) {
    final _library = library;
    if (_library is String) {
      return _library;
    } else if (_library is bool) {
      final name = this.name;
      if (_library && name != null) {
        return name;
      }
    }
    return folderName;
  }

  factory IndexSettings.fromJson(Map data) => _$IndexSettingsFromJson(data);
  @override
  Map<String, dynamic> toJson() => _$IndexSettingsToJson(this);
}

@JsonSerializable()
class ExportSettings implements Stringify {
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
  @override
  Map<String, dynamic> toJson() => _$ExportSettingsToJson(this);
}
