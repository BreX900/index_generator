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

  final List<String> exports;

  /// Export this folder paths
  final List<String> folders;

  /// Black or white filters
  final List<Filter> filters;

  const IndexSettings({
    required this.path,
    this.name,
    this.exports = const <String>[],
    this.folders = const <String>[''],
    this.filters = const <Filter>[],
    this.library,
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
