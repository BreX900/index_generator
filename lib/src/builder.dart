// ignore_for_file: depend_on_referenced_packages
import 'dart:io';

import 'package:build/build.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:dart_style/dart_style.dart';
import 'package:index_generator/src/index_generator.dart';
import 'package:index_generator/src/settings/dart.dart';
import 'package:index_generator/src/settings/package_settings.dart';

Builder indexGeneratorBuilder(BuilderOptions options) {
  final toolBox = ToolBoxSync(name: 'index_generator');
  final project = ToolBoxSync.loadYaml(toolBox.projectYaml, Pubspec.fromJson);
  final settingsFile = toolBox.findYaml(null);
  final settings = ToolBoxSync.loadYaml(settingsFile, PackageSettings.fromYaml);
  return IndexGeneratorBuilder(project, settings);
}

class IndexGeneratorBuilder implements Builder {
  IndexGeneratorBuilder(Pubspec project, this.package) {
    generators = package.libraries.map((library) {
      return IndexGenerator.from(project, null, package, library);
    }).toList();
  }
  late final List<IndexGenerator> generators;
  final PackageSettings package;

  static AssetId _createFileOutput(BuildStep buildStep, String filePath) {
    return AssetId(
      buildStep.inputId.package,
      filePath,
    );
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      r'$package$': generators.map((g) => g.indexFile.path).toList(),
    };
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    final formatter = DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
      lineEnding: package.lineBreak,
      pageWidth: package.pageWidth,
    );
    for (final generator in generators) {
      final content = formatter.format(generator.generate().join(package.lineBreak));
      final output = _createFileOutput(buildStep, generator.indexFile.path);
      await buildStep.writeAsString(output, content);
    }
  }
}

class ToolBoxSync {
  ToolBoxSync({required String name}) : packageYaml = File('$name.yaml');
  final File projectYaml = File('pubspec.yaml');
  final File packageYaml;

  File findYaml(String? path) {
    if (path != null) return File(path);

    if (packageYaml.existsSync()) return packageYaml;

    return projectYaml;
  }

  static T loadYaml<T>(File file, T Function(Map map) from) {
    if (!file.existsSync()) {
      throw Exception('Not find ${file.path} file in this project');
    }
    try {
      return checkedYamlDecode(
        file.readAsStringSync(),
        (map) => from(map!),
        sourceUrl: Uri.file(file.path),
      );
    } on ParsedYamlException catch (error) {
      throw Exception(error.formattedMessage);
    }
  }
}
