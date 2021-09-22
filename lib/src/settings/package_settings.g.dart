// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSettings _$ProjectSettingsFromJson(Map json) => $checkedCreate(
      'ProjectSettings',
      json,
      ($checkedConvert) {
        final val = ProjectSettings(
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProjectSettingsToJson(ProjectSettings instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

PackageSettings _$PackageSettingsFromJson(Map json) => $checkedCreate(
      'PackageSettings',
      json,
      ($checkedConvert) {
        final val = PackageSettings(
          lineBreak:
              $checkedConvert('line_break', (v) => v as String? ?? '\u{000A}'),
          defaultName: $checkedConvert('default_name', (v) => v as String?),
          filters: $checkedConvert(
              'filters',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Filter.fromJson(e as Map))
                      .toList() ??
                  const <Filter>[]),
          indexes: $checkedConvert(
              'indexes',
              (v) => (v as List<dynamic>)
                  .map((e) => IndexSettings.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'lineBreak': 'line_break',
        'defaultName': 'default_name'
      },
    );

Map<String, dynamic> _$PackageSettingsToJson(PackageSettings instance) =>
    <String, dynamic>{
      'line_break': instance.lineBreak,
      'default_name': instance.defaultName,
      'filters': instance.filters,
      'indexes': instance.indexes,
    };

GeneralSettings _$GeneralSettingsFromJson(Map json) => $checkedCreate(
      'GeneralSettings',
      json,
      ($checkedConvert) {
        final val = GeneralSettings(
          indexGenerator: $checkedConvert(
              'index_generator', (v) => PackageSettings.fromJson(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {'indexGenerator': 'index_generator'},
    );

Map<String, dynamic> _$GeneralSettingsToJson(GeneralSettings instance) =>
    <String, dynamic>{
      'index_generator': instance.indexGenerator,
    };
