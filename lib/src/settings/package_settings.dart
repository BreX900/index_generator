import 'package:glob/glob.dart';
import 'package:index_generator/src/converters.dart';
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
@GlobJsonConverter()
class PackageSettings implements Stringify {
  final String lineBreak;
  final int pageWidth;
  final String? defaultName;
  final List<Glob> include;
  final List<Glob> exclude;
  final List<IndexSettings> indexes;

  const PackageSettings({
    this.lineBreak = '\u{000A}',
    this.pageWidth = 80,
    required this.defaultName,
    this.include = const [],
    this.exclude = const [],
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
