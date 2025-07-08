// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_settings.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$LibrarySettings {
  LibrarySettings get _self => this as LibrarySettings;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibrarySettings &&
          runtimeType == other.runtimeType &&
          _self.directoryPath == other.directoryPath &&
          _self.outputPath == other.outputPath &&
          _self.fileName == other.fileName &&
          _self.disclaimer == other.disclaimer &&
          _self.includeLibrary == other.includeLibrary &&
          _self.comments == other.comments &&
          _self.docs == other.docs &&
          _self.name == other.name &&
          $listEquality.equals(_self.exports, other.exports) &&
          $listEquality.equals(_self.include, other.include) &&
          $listEquality.equals(_self.exclude, other.exclude) &&
          _self.usePackageExports == other.usePackageExports;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.directoryPath.hashCode);
    hashCode = $hashCombine(hashCode, _self.outputPath.hashCode);
    hashCode = $hashCombine(hashCode, _self.fileName.hashCode);
    hashCode = $hashCombine(hashCode, _self.disclaimer.hashCode);
    hashCode = $hashCombine(hashCode, _self.includeLibrary.hashCode);
    hashCode = $hashCombine(hashCode, _self.comments.hashCode);
    hashCode = $hashCombine(hashCode, _self.docs.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.exports));
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.include));
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.exclude));
    hashCode = $hashCombine(hashCode, _self.usePackageExports.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('LibrarySettings')
        ..add('directoryPath', _self.directoryPath)
        ..add('outputPath', _self.outputPath)
        ..add('fileName', _self.fileName)
        ..add('disclaimer', _self.disclaimer)
        ..add('includeLibrary', _self.includeLibrary)
        ..add('comments', _self.comments)
        ..add('docs', _self.docs)
        ..add('name', _self.name)
        ..add('exports', _self.exports)
        ..add('include', _self.include)
        ..add('exclude', _self.exclude)
        ..add('usePackageExports', _self.usePackageExports))
      .toString();
}

mixin _$ExportSettings {
  ExportSettings get _self => this as ExportSettings;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExportSettings &&
          runtimeType == other.runtimeType &&
          _self.package == other.package &&
          $listEquality.equals(_self.show, other.show) &&
          $listEquality.equals(_self.hide, other.hide);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.package.hashCode);
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.show));
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.hide));
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('ExportSettings')
        ..add('package', _self.package)
        ..add('show', _self.show)
        ..add('hide', _self.hide))
      .toString();
}

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
