// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexSettings _$IndexSettingsFromJson(Map json) => $checkedCreate(
      'IndexSettings',
      json,
      ($checkedConvert) {
        final val = IndexSettings(
          path: $checkedConvert('path', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          library: $checkedConvert('library', (v) => v),
          exports: $checkedConvert(
              'exports',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => ExportSettings.fromJson(e as Map))
                      .toList() ??
                  const <ExportSettings>[]),
          include: $checkedConvert(
              'include',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          const GlobJsonConverter().fromJson(e as String))
                      .toList() ??
                  const <Glob>[]),
          exclude: $checkedConvert(
              'exclude',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          const GlobJsonConverter().fromJson(e as String))
                      .toList() ??
                  const <Glob>[]),
        );
        return val;
      },
    );

Map<String, dynamic> _$IndexSettingsToJson(IndexSettings instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'library': instance.library,
      'exports': instance.exports,
      'include':
          instance.include.map(const GlobJsonConverter().toJson).toList(),
      'exclude':
          instance.exclude.map(const GlobJsonConverter().toJson).toList(),
    };

ExportSettings _$ExportSettingsFromJson(Map json) => $checkedCreate(
      'ExportSettings',
      json,
      ($checkedConvert) {
        final val = ExportSettings(
          package: $checkedConvert('package', (v) => v as String),
          show: $checkedConvert(
              'show',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          hide: $checkedConvert(
              'hide',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$ExportSettingsToJson(ExportSettings instance) =>
    <String, dynamic>{
      'package': instance.package,
      'show': instance.show,
      'hide': instance.hide,
    };
