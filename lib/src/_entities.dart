import 'package:yaml/yaml.dart';

List<String> getListString(dynamic data, String name) {
  return (data[name] as YamlList?)?.cast<String>().toList() ?? const <String>[];
}

class Config {
  final String name;

  final String? defaultName;
  final bool canUseLibrary;
  final List<Filter> filters;
  final List<Index> indexes;

  const Config({
    required this.name,
    this.defaultName,
    this.canUseLibrary = true,
    this.filters = const <Filter>[],
    this.indexes = const <Index>[],
  });

  factory Config.from(dynamic yamlFile) {
    final data = yamlFile['index_generator'];
    return Config(
      name: yamlFile['name'],
      defaultName: data['default_name'],
      canUseLibrary: data['library'] ?? true,
      filters: Filter.listFrom(data['filters']),
      indexes: Index.listFrom(data['indexes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (defaultName != null) 'index_name': defaultName,
      'canUseLibrary': canUseLibrary,
      'filters': filters,
      'indexes': indexes.map((e) => e.toMap()).toList(),
    };
  }
}

class Index {
  final String? name;
  final String path;
  final List<String> folders;
  final bool? canUseLibrary;
  final String? library;
  final List<Filter> filters;

  const Index({
    this.name,
    required this.path,
    this.folders = const <String>[],
    this.canUseLibrary,
    this.library,
    this.filters = const <Filter>[],
  });

  factory Index.from(YamlMap data) {
    final library = data['library'];
    bool? canUseLibrary;
    String? libraryName;
    if (library is String) {
      canUseLibrary = true;
      libraryName = library;
    } else if (library is bool) {
      canUseLibrary = library;
    }
    final destination = data['path'] as String?;
    if (destination == null) throw 'Path is Required';
    final exportFolders = getListString(data, 'export');
    return Index(
      name: data['name'] as String?,
      path: destination,
      folders: exportFolders.isEmpty ? [destination] : exportFolders,
      filters: Filter.listFrom(data['filters']),
      canUseLibrary: canUseLibrary,
      library: libraryName,
    );
  }

  static List<Index> listFrom(YamlList? data) {
    return (data ?? YamlList()).map((element) {
      return Index.from(element);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'indexName': name,
      'path': path,
      'directories': folders,
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
