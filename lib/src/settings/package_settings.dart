import 'package:index_generator/src/settings/filters.dart';
import 'package:index_generator/src/settings/index_settings.dart';
import 'package:index_generator/src/stringify.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_settings.g.dart';

@JsonSerializable()
class ProjectSettings implements Stringify {
  final String name;

  const ProjectSettings({required this.name});

  static ProjectSettings fromJson(Map map) => _$ProjectSettingsFromJson(map);
  @override
  Map<String, dynamic> toJson() => _$ProjectSettingsToJson(this);
}

@JsonSerializable()
class PackageSettings implements Stringify {
  final String lineBreak;
  final String? defaultName;
  final List<Filter> filters;
  final List<IndexSettings> indexes;

  const PackageSettings({
    this.lineBreak = '\u{000A}',
    required this.defaultName,
    this.filters = const <Filter>[],
    required this.indexes,
  });

  static PackageSettings fromYaml(Map map) => GeneralSettings.fromJson(map).indexGenerator;

  factory PackageSettings.fromJson(Map map) => _$PackageSettingsFromJson(map);
  @override
  Map<String, dynamic> toJson() => _$PackageSettingsToJson(this);
}

@JsonSerializable()
class GeneralSettings implements Stringify {
  final PackageSettings indexGenerator;

  const GeneralSettings({required this.indexGenerator});

  factory GeneralSettings.fromJson(Map map) => _$GeneralSettingsFromJson(map);
  @override
  Map<String, dynamic> toJson() => _$GeneralSettingsToJson(this);
}
