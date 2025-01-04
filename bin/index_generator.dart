import 'dart:io';

import 'package:args/args.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:console/console.dart';
import 'package:index_generator/index_generator.dart';
import 'package:index_generator/src/settings/dart.dart';

final argsParser = ArgParser()
  ..addOption(
    'settings',
    abbr: 's',
    valueHelp: 'Define a yaml file path.',
    help:
        'If not present use the "index_generator.yaml" file if it exists otherwise use the "pubspec.yaml" file.',
  )
  ..addFlag('verbose', abbr: 'v', defaultsTo: false, help: 'Print verbose logs')
  ..addFlag('help', abbr: 'h', defaultsTo: false, negatable: false);

final toolBox = ToolBox(name: 'index_generator');

void main(List<String> rawArgs) async {
  final args = argsParser.parse(rawArgs);
  final settingsPath = args['settings'] as String?;
  final canVerbose = args['verbose'] as bool;
  final askHelp = args['help'] as bool;

  if (askHelp) {
    print(argsParser.usage);
    exit(0);
  }

  Print.workInfo('Initializing work space...');

  final pubspec = await ToolBox.loadYaml(toolBox.projectYaml, Pubspec.fromJson);
  final analysisOptions =
      await ToolBox.tryLoadYaml(toolBox.analysisOptions, AnalysisOptions.fromJson);
  final settingsFile = await toolBox.findYaml(settingsPath);
  Print.verbose('Settings file: ${settingsFile.path}');
  final settings = await ToolBox.loadYaml(settingsFile, PackageSettings.fromYaml);

  if (canVerbose) {
    Print.verbose(pubspec);
    Print.verbose(settings);
  }

  final generators = settings.libraries.map((library) {
    return IndexGenerator.from(pubspec, analysisOptions, settings, library);
  }).toList();

  Print.workInfo('Initialized work space!');
  Print.workInfo('Creating index files...');
  final progress = Progress(total: generators.length);

  await Future.wait(generators.map((generator) async {
    await generator.create();
    Print.workInfo('${progress.next()}: Created ${generator.indexFile.path}!');
  }));

  Print.workInfo('Created index files!');
}

class ToolBox {
  final File projectYaml = File('pubspec.yaml');
  final File analysisOptions = File('analysis_options.yaml');
  final File packageYaml;

  ToolBox({required String name}) : packageYaml = File('$name.yaml');

  Future<File> findYaml(String? path) async {
    if (path != null) return File(path);

    if (await packageYaml.exists()) return packageYaml;

    return projectYaml;
  }

  static Future<T> loadYaml<T>(File file, T Function(Map map) from) async {
    final yaml = await tryLoadYaml(file, from);
    if (yaml == null) {
      Print.error('Not find ${file.path} file in this project');
      exit(-1);
    }
    return yaml;
  }

  static Future<T?> tryLoadYaml<T>(File file, T Function(Map map) from) async {
    if (!await file.exists()) return null;
    try {
      return checkedYamlDecode(
        await file.readAsString(),
        (map) => from(map!),
        sourceUrl: Uri.file(file.path),
      );
    } on ParsedYamlException catch (error) {
      Print.error(error.formattedMessage!);
      exit(-1);
    }
  }
}

enum ProgressStyle { fraction, percent }

class Progress {
  final ProgressStyle style;
  final int total;
  int _count = 0;

  Progress({this.style = ProgressStyle.fraction, required this.total});

  String next() {
    _count += 1;
    switch (style) {
      case ProgressStyle.fraction:
        return '$_count/$total';
      case ProgressStyle.percent:
        return '${(_count / total).toStringAsFixed(2)}%';
    }
  }
}

class Print {
  static void verbose(Object message) {
    Console.setTextColor(Color.YELLOW.id);
    Console.write('$message\n');
    Console.resetTextColor();
  }

  static void workInfo(Object message) {
    Console.setTextColor(Color.GREEN.id);
    Console.write('$message\n');
    Console.resetTextColor();
  }

  static void spaceInfo(Object message) {
    Console.setTextColor(Color.DARK_BLUE.id);
    Console.write('$message\n');
    Console.resetTextColor();
  }

  static void error(Object message) {
    Console.setTextColor(Color.RED.id);
    Console.write('$message\n');
    Console.resetTextColor();
  }
}
