import 'dart:io';

import 'package:args/args.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:console/console.dart';
import 'package:index_generator/index_generator.dart';

final argsParser = ArgParser()
  ..addOption('settings', abbr: 's', valueHelp: 'Define a yaml file path.')
  ..addFlag('verbose', abbr: 'v', defaultsTo: false, help: 'Print more logs')
  ..addFlag('help', abbr: 'h', defaultsTo: false, negatable: false);

final toolBox = ToolBox(name: 'index_generator.yaml');

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

  final project = await ToolBox.loadYaml(toolBox.projectYaml, ProjectSettings.fromJson);
  final settingsFile = await toolBox.findYaml(settingsPath);
  final settings = await ToolBox.loadYaml(settingsFile, PackageSettings.fromYaml);

  if (canVerbose) {
    Print.verbose(Stringifier.minimal(
      identity: ' ',
      lineBreak: '\n',
    ).stringify(project));
    Print.verbose(Stringifier.minimal(
      identity: ' ',
      lineBreak: '\n',
    ).stringify(settings));
  }

  final generators = settings.indexes.map((index) {
    return IndexGenerator.from(project, settings, index);
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
  final File packageYaml;

  ToolBox({required String name}) : packageYaml = File('$name.yaml');

  Future<File> findYaml(String? path) async {
    if (path != null) return File(path);

    if (await packageYaml.exists()) return packageYaml;

    return projectYaml;
  }

  static Future<T> loadYaml<T>(File file, T Function(Map map) from) async {
    if (!await file.exists()) {
      Print.error('Not find ${file.path} file in this project');
      exit(-1);
    }
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
