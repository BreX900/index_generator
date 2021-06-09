import 'dart:convert';
import 'dart:io';

import 'package:index_generator/src/_entities.dart';
import 'package:index_generator/src/index_generator.dart';
import 'package:yaml/yaml.dart';

void main() {
  final pubSpecFile = File('./pubspec.yaml');

  final pubSpec = loadYaml(pubSpecFile.readAsStringSync());
  // print(pubSpec);
  final config = Config.from(pubSpec);
  print('Current Configuration:');
  print(JsonEncoder.withIndent(' ', (o) => '$o').convert(config.toMap()));

  final generators = config.indexes.map((folder) {
    return IndexGenerator.from(config: config, folder: folder);
  }).toList();

  print('Created index files(${generators.length}):');
  for (var i = 0; i < generators.length; i++) {
    final generator = generators[i];
    if (!isTestingMode) {
      generator.create();
    }
    print('  ${i + 1}. ${generator.indexFile.path}');
    if (isTestingMode) {
      print(generator.generate().map((e) => '     - $e').join('\n'));
    }
  }
}
