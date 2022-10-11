import 'package:glob/glob.dart';
import 'package:index_generator/src/converters.dart';
import 'package:index_generator/src/settings/library_settings.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'package_settings.g.dart';

@DataClass()
@JsonSerializable()
class ProjectSettings with _$ProjectSettings {
  final String name;

  const ProjectSettings({required this.name});

  factory ProjectSettings.fromJson(Map map) => _$ProjectSettingsFromJson(map);
}

@DataClass()
@JsonSerializable()
@GlobJsonConverter()
class PackageSettings with _$PackageSettings {
  final String lineBreak;
  final int pageWidth;
  @JsonKey(name: 'default_name')
  final String? defaultFileName;
  final List<Glob> include;
  final List<Glob> exclude;
  @JsonKey(name: 'indexes')
  final List<LibrarySettings> libraries;

  const PackageSettings({
    this.lineBreak = '\u{000A}',
    this.pageWidth = 80,
    required this.defaultFileName,
    this.include = const [],
    this.exclude = const [],
    required this.libraries,
  });

  factory PackageSettings.fromYaml(Map map) => GeneralSettings.fromJson(map).indexGenerator;

  factory PackageSettings.fromJson(Map map) => _$PackageSettingsFromJson(map);
}

@DataClass()
@JsonSerializable()
class GeneralSettings with _$GeneralSettings {
  final PackageSettings indexGenerator;

  const GeneralSettings({required this.indexGenerator});

  factory GeneralSettings.fromJson(Map map) => _$GeneralSettingsFromJson(map);
}
