// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable

part of 'library_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibrarySettings _$LibrarySettingsFromJson(Map json) => $checkedCreate(
      'LibrarySettings',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'directory_path',
            'output_path',
            'file_name',
            'disclaimer',
            'include_library',
            'comments',
            'docs',
            'name',
            'exports',
            'include',
            'exclude',
            'use_package_exports'
          ],
        );
        final val = LibrarySettings(
          directoryPath: $checkedConvert('directory_path', (v) => v as String),
          outputPath: $checkedConvert('output_path', (v) => v as String?),
          fileName: $checkedConvert('file_name', (v) => v as String?),
          disclaimer: $checkedConvert('disclaimer', (v) => v as bool? ?? true),
          includeLibrary:
              $checkedConvert('include_library', (v) => v as bool? ?? true),
          comments: $checkedConvert('comments', (v) => v as String? ?? ''),
          docs: $checkedConvert('docs', (v) => v as String? ?? ''),
          name: $checkedConvert('name', (v) => v as String?),
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
          usePackageExports: $checkedConvert(
              'use_package_exports', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'directoryPath': 'directory_path',
        'outputPath': 'output_path',
        'fileName': 'file_name',
        'includeLibrary': 'include_library',
        'usePackageExports': 'use_package_exports'
      },
    );

ExportSettings _$ExportSettingsFromJson(Map json) => $checkedCreate(
      'ExportSettings',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['package', 'show', 'hide'],
        );
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
