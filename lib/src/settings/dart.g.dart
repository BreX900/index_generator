// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable

part of 'dart.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Pubspec {
  Pubspec get _self => this as Pubspec;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pubspec &&
          runtimeType == other.runtimeType &&
          _self.name == other.name &&
          _self.environment == other.environment;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.environment.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Pubspec')
        ..add('name', _self.name)
        ..add('environment', _self.environment))
      .toString();
}

mixin _$PubspecEnvironment {
  PubspecEnvironment get _self => this as PubspecEnvironment;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PubspecEnvironment &&
          runtimeType == other.runtimeType &&
          _self.sdk == other.sdk;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.sdk.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('PubspecEnvironment')..add('sdk', _self.sdk)).toString();
}

mixin _$AnalysisOptions {
  AnalysisOptions get _self => this as AnalysisOptions;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalysisOptions &&
          runtimeType == other.runtimeType &&
          _self.formatter == other.formatter;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.formatter.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('AnalysisOptions')..add('formatter', _self.formatter))
          .toString();
}

mixin _$FormatterOptions {
  FormatterOptions get _self => this as FormatterOptions;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatterOptions &&
          runtimeType == other.runtimeType &&
          _self.pageWidth == other.pageWidth;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.pageWidth.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('FormatterOptions')..add('pageWidth', _self.pageWidth))
          .toString();
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubspec _$PubspecFromJson(Map json) => $checkedCreate(
      'Pubspec',
      json,
      ($checkedConvert) {
        final val = Pubspec(
          name: $checkedConvert('name', (v) => v as String),
          environment: $checkedConvert(
              'environment', (v) => PubspecEnvironment.fromJson(v as Map)),
        );
        return val;
      },
    );

PubspecEnvironment _$PubspecEnvironmentFromJson(Map json) => $checkedCreate(
      'PubspecEnvironment',
      json,
      ($checkedConvert) {
        final val = PubspecEnvironment(
          sdk: $checkedConvert(
              'sdk', (v) => VersionConstraint.parse(v as String)),
        );
        return val;
      },
    );

AnalysisOptions _$AnalysisOptionsFromJson(Map json) => $checkedCreate(
      'AnalysisOptions',
      json,
      ($checkedConvert) {
        final val = AnalysisOptions(
          formatter: $checkedConvert(
              'formatter',
              (v) => v == null
                  ? const FormatterOptions()
                  : FormatterOptions.fromJson(v as Map)),
        );
        return val;
      },
    );

FormatterOptions _$FormatterOptionsFromJson(Map json) => $checkedCreate(
      'FormatterOptions',
      json,
      ($checkedConvert) {
        final val = FormatterOptions(
          pageWidth:
              $checkedConvert('page_width', (v) => (v as num?)?.toInt() ?? 80),
        );
        return val;
      },
      fieldKeyMap: const {'pageWidth': 'page_width'},
    );
