// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_settings.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, unused_element

mixin _$ProjectSettings {
  ProjectSettings get _self => this as ProjectSettings;

  Iterable<Object?> get _props sync* {
    yield _self.name;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$ProjectSettings &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() =>
      (ClassToString('ProjectSettings')..add('name', _self.name)).toString();
}

mixin _$PackageSettings {
  PackageSettings get _self => this as PackageSettings;

  Iterable<Object?> get _props sync* {
    yield _self.lineBreak;
    yield _self.pageWidth;
    yield _self.defaultFileName;
    yield _self.include;
    yield _self.exclude;
    yield _self.libraries;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$PackageSettings &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('PackageSettings')
        ..add('lineBreak', _self.lineBreak)
        ..add('pageWidth', _self.pageWidth)
        ..add('defaultFileName', _self.defaultFileName)
        ..add('include', _self.include)
        ..add('exclude', _self.exclude)
        ..add('libraries', _self.libraries))
      .toString();
}

mixin _$GeneralSettings {
  GeneralSettings get _self => this as GeneralSettings;

  Iterable<Object?> get _props sync* {
    yield _self.indexGenerator;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$GeneralSettings &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('GeneralSettings')
        ..add('indexGenerator', _self.indexGenerator))
      .toString();
}

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

PackageSettings _$PackageSettingsFromJson(Map json) => $checkedCreate(
      'PackageSettings',
      json,
      ($checkedConvert) {
        final val = PackageSettings(
          lineBreak:
              $checkedConvert('line_break', (v) => v as String? ?? '\u{000A}'),
          pageWidth: $checkedConvert('page_width', (v) => v as int? ?? 80),
          defaultFileName: $checkedConvert('default_name', (v) => v as String?),
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
              'indexes',
              (v) => (v as List<dynamic>)
                  .map((e) => LibrarySettings.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'lineBreak': 'line_break',
        'pageWidth': 'page_width',
        'defaultFileName': 'default_name',
        'libraries': 'indexes'
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
