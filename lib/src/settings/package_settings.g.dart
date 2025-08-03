// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable

part of 'package_settings.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$PackageSettings {
  PackageSettings get _self => this as PackageSettings;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageSettings &&
          runtimeType == other.runtimeType &&
          _self.lineBreak == other.lineBreak &&
          _self.pageWidth == other.pageWidth &&
          _self.defaultFileName == other.defaultFileName &&
          $listEquality.equals(_self.include, other.include) &&
          $listEquality.equals(_self.exclude, other.exclude) &&
          $listEquality.equals(_self.libraries, other.libraries);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.lineBreak.hashCode);
    hashCode = $hashCombine(hashCode, _self.pageWidth.hashCode);
    hashCode = $hashCombine(hashCode, _self.defaultFileName.hashCode);
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.include));
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.exclude));
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.libraries));
    return $hashFinish(hashCode);
  }

  @override
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralSettings &&
          runtimeType == other.runtimeType &&
          _self.indexGenerator == other.indexGenerator;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.indexGenerator.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('GeneralSettings')
        ..add('indexGenerator', _self.indexGenerator))
      .toString();
}

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
