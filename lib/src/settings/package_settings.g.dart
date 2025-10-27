// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable

part of 'package_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageSettings _$PackageSettingsFromJson(Map json) => $checkedCreate(
      'PackageSettings',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'line_break',
            'page_width',
            'default_file_name',
            'include',
            'exclude',
            'libraries'
          ],
        );
        final val = PackageSettings(
          lineBreak:
              $checkedConvert('line_break', (v) => v as String? ?? '\u{000A}'),
          pageWidth: $checkedConvert('page_width', (v) => (v as num?)?.toInt()),
          defaultFileName:
              $checkedConvert('default_file_name', (v) => v as String?),
          include: $checkedConvert(
              'include',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          const GlobJsonConverter().fromJson(e as String))
                      .toList() ??
                  const []),
          exclude: $checkedConvert(
              'exclude',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          const GlobJsonConverter().fromJson(e as String))
                      .toList() ??
                  const []),
          libraries: $checkedConvert(
              'libraries',
              (v) => (v as List<dynamic>)
                  .map((e) => LibrarySettings.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'lineBreak': 'line_break',
        'pageWidth': 'page_width',
        'defaultFileName': 'default_file_name'
      },
    );

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
