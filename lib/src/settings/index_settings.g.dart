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
          filters: $checkedConvert(
              'filters',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Filter.fromJson(e as Map))
                      .toList() ??
                  const <Filter>[]),
          folders: $checkedConvert(
              'folders',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const <String>['']),
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
      'filters': instance.filters,
      'folders': instance.folders,
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
