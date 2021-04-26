import 'package:yaml/yaml.dart';

List<String> getListString(dynamic data, String name) {
  return (data[name] as YamlList?)?.cast<String>().toList() ?? const <String>[];
}

class Config {
  final String name;

  final String? indexName;
  final bool canUseLibrary;
  final List<Filter> filters;
  final List<Folder> folders;

  const Config({
    required this.name,
    this.indexName,
    this.canUseLibrary = true,
    this.filters = const <Filter>[],
    this.folders = const <Folder>[],
  });

  factory Config.from(dynamic yamlFile) {
    final data = yamlFile['index_generator'];
    return Config(
      name: yamlFile['name'],
      indexName: data['index_name'],
      canUseLibrary: data['library'] ?? true,
      filters: Filter.listFrom(data['filters']),
      folders: Folder.listFrom(data['folders']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (indexName != null) 'indexName': indexName,
      'canUseLibrary': canUseLibrary,
      if (filters.isNotEmpty) 'filters': filters,
      if (folders.isNotEmpty) 'folders': folders.map((e) => e.toMap()).toList(),
    };
  }
}

class Folder {
  final String path;
  final String? indexName;
  final bool? canUseLibrary;
  final String? library;
  final List<Filter> filters;

  const Folder({
    required this.path,
    this.indexName,
    this.canUseLibrary,
    this.library,
    this.filters = const <Filter>[],
  });

  factory Folder.from(YamlMap data) {
    final library = data['library'];
    bool? canUseLibrary;
    String? libraryName;
    if (library is String) {
      canUseLibrary = true;
      libraryName = library;
    } else if (library is bool) {
      canUseLibrary = library;
    }
    return Folder(
      path: data['path'],
      indexName: data['index_name'],
      filters: Filter.listFrom(data['filters']),
      canUseLibrary: canUseLibrary,
      library: libraryName,
    );
  }

  static List<Folder> listFrom(YamlList? data) {
    return (data ?? YamlList()).map((element) {
      return Folder.from(element);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      if (indexName != null) 'indexName': indexName,
      if (filters.isNotEmpty) 'filters': filters,
      if (canUseLibrary != null) 'canUseLibrary': canUseLibrary,
      if (library != null) 'library': library,
    };
  }
}

abstract class Filter {
  final RegExp regExp;

  const Filter(this.regExp);

  factory Filter.from(YamlMap data) {
    final regExp = RegExp(data.values.single);
    switch (data.keys.single) {
      case 'white':
        return WhiteFilter(regExp);
      case 'black':
        return BlackFilter(regExp);
    }
    throw 'Not support filter, you can use only "black" or "white"';
  }

  static List<Filter> listFrom(YamlList? data) {
    return (data ?? YamlList()).map((element) {
      return Filter.from(element);
    }).toList();
  }

  bool accept(String str);

  @override
  String toString();
}

class WhiteFilter extends Filter {
  WhiteFilter(RegExp regExp) : super(regExp);

  @override
  bool accept(String str) => regExp.hasMatch(str);

  @override
  String toString() => 'WhiteFilter(${regExp.pattern})';
}

class BlackFilter extends Filter {
  BlackFilter(RegExp regExp) : super(regExp);

  @override
  bool accept(String str) => !regExp.hasMatch(str);

  @override
  String toString() => 'BlackFilter(${regExp.pattern})';
}
