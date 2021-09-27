import 'package:index_generator/index_generator.dart';
import 'package:index_generator/src/settings/filters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'index_settings.g.dart';

@JsonSerializable()
class IndexSettings implements Stringify {
  /// Folder path to create a index file
  final String path;

  /// File name with extension
  final String? name;

  /// Library name
  final Object? library;

  /// List of export packages
  final List<ExportSettings> exports;

  /// Black or white filters
  final List<Filter> filters;

  /// Export this folder paths
  final List<String> folders;

  const IndexSettings({
    required this.path,
    this.name,
    this.library,
    this.exports = const <ExportSettings>[],
    this.filters = const <Filter>[],
    this.folders = const <String>[''],
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
