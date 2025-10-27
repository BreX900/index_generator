// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable

part of 'dart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubspec _$PubspecFromJson(Map json) => $checkedCreate(
      'Pubspec',
      json,
      ($checkedConvert) {
        final val = Pubspec(
          name: $checkedConvert('name', (v) => v as String),
          environment: $checkedConvert(
              'environment', (v) => PubspecEnvironment.fromJson(v as Map)),
        );
        return val;
      },
    );

PubspecEnvironment _$PubspecEnvironmentFromJson(Map json) => $checkedCreate(
      'PubspecEnvironment',
      json,
      ($checkedConvert) {
        final val = PubspecEnvironment(
          sdk: $checkedConvert(
              'sdk', (v) => VersionConstraint.parse(v as String)),
        );
        return val;
      },
    );

AnalysisOptions _$AnalysisOptionsFromJson(Map json) => $checkedCreate(
      'AnalysisOptions',
      json,
      ($checkedConvert) {
        final val = AnalysisOptions(
          formatter: $checkedConvert(
              'formatter',
              (v) => v == null
                  ? const FormatterOptions()
                  : FormatterOptions.fromJson(v as Map)),
        );
        return val;
      },
    );

FormatterOptions _$FormatterOptionsFromJson(Map json) => $checkedCreate(
      'FormatterOptions',
      json,
      ($checkedConvert) {
        final val = FormatterOptions(
          pageWidth:
              $checkedConvert('page_width', (v) => (v as num?)?.toInt() ?? 80),
        );
        return val;
      },
      fieldKeyMap: const {'pageWidth': 'page_width'},
    );
