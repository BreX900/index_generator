import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:pub_semver/pub_semver.dart';

part 'dart.g.dart';

@DataClass()
@JsonSerializable(disallowUnrecognizedKeys: false)
class Pubspec with _$Pubspec {
  final String name;
  final PubspecEnvironment environment;

  const Pubspec({required this.name, required this.environment});

  factory Pubspec.fromJson(Map<dynamic, dynamic> map) => _$PubspecFromJson(map);
}

@DataClass()
@JsonSerializable(disallowUnrecognizedKeys: false)
class PubspecEnvironment with _$PubspecEnvironment {
  @JsonKey(fromJson: VersionConstraint.parse)
  final VersionConstraint sdk;

  const PubspecEnvironment({required this.sdk});

  factory PubspecEnvironment.fromJson(Map<dynamic, dynamic> map) =>
      _$PubspecEnvironmentFromJson(map);
}

@DataClass()
@JsonSerializable(disallowUnrecognizedKeys: false)
class AnalysisOptions with _$AnalysisOptions {
  final FormatterOptions formatter;

  const AnalysisOptions({this.formatter = const FormatterOptions()});

  factory AnalysisOptions.fromJson(Map<dynamic, dynamic> map) => _$AnalysisOptionsFromJson(map);
}

@DataClass()
@JsonSerializable(disallowUnrecognizedKeys: false)
class FormatterOptions with _$FormatterOptions {
  final int pageWidth;

  const FormatterOptions({this.pageWidth = 80});

  factory FormatterOptions.fromJson(Map<dynamic, dynamic> map) => _$FormatterOptionsFromJson(map);
}
