// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_settings.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$LibrarySettings {
  LibrarySettings get _self => this as LibrarySettings;

  Iterable<Object?> get _props sync* {
    yield _self.dirPath;
    yield _self.fileName;
    yield _self.disclaimer;
    yield _self.comments;
    yield _self.docs;
    yield _self.name;
    yield _self.exports;
    yield _self.include;
    yield _self.exclude;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$LibrarySettings &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('LibrarySettings')
        ..add('dirPath', _self.dirPath)
        ..add('fileName', _self.fileName)
        ..add('disclaimer', _self.disclaimer)
        ..add('comments', _self.comments)
        ..add('docs', _self.docs)
        ..add('name', _self.name)
        ..add('exports', _self.exports)
        ..add('include', _self.include)
        ..add('exclude', _self.exclude))
      .toString();
}

mixin _$ExportSettings {
  ExportSettings get _self => this as ExportSettings;

  Iterable<Object?> get _props sync* {
    yield _self.package;
    yield _self.show;
    yield _self.hide;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$ExportSettings &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

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
        final val = LibrarySettings(
          dirPath: $checkedConvert('path', (v) => v as String),
          fileName: $checkedConvert('name', (v) => v as String?),
          disclaimer: $checkedConvert('disclaimer', (v) => v as bool? ?? true),
          comments: $checkedConvert('comments', (v) => v as String? ?? ''),
          docs: $checkedConvert('docs', (v) => v as String? ?? ''),
          name: $checkedConvert('library', (v) => v as String?),
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
      fieldKeyMap: const {
        'dirPath': 'path',
        'fileName': 'name',
        'name': 'library'
      },
    );

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
