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
          exports: $checkedConvert(
              'exports',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const <String>[]),
          folders: $checkedConvert(
              'folders',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const <String>['']),
          filters: $checkedConvert(
              'filters',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Filter.fromJson(e as Map))
                      .toList() ??
                  const <Filter>[]),
          library: $checkedConvert('library', (v) => v),
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
      'folders': instance.folders,
      'filters': instance.filters,
    };
