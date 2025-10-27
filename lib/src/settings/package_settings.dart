import 'package:glob/glob.dart';
import 'package:index_generator/src/converters.dart';
import 'package:index_generator/src/settings/library_settings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_settings.g.dart';

@JsonSerializable()
@GlobJsonConverter()
class PackageSettings {
  final String lineBreak;
  final int? pageWidth;
  final String? defaultFileName;
  final List<Glob> include;
  final List<Glob> exclude;
  final List<LibrarySettings> libraries;

  const PackageSettings({
    this.lineBreak = '\u{000A}',
    this.pageWidth,
    required this.defaultFileName,
    this.include = const [],
    this.exclude = const [],
    required this.libraries,
  });

  factory PackageSettings.fromYaml(Map map) => GeneralSettings.fromJson(map).indexGenerator;

  factory PackageSettings.fromJson(Map map) => _$PackageSettingsFromJson(map);
}

@JsonSerializable(disallowUnrecognizedKeys: false)
class GeneralSettings {
  final PackageSettings indexGenerator;

  const GeneralSettings({required this.indexGenerator});

  factory GeneralSettings.fromJson(Map map) => _$GeneralSettingsFromJson(map);
}
