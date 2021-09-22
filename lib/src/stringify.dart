import 'dart:convert';

abstract class Stringify {
  Map<String, dynamic> toJson();
}

abstract class Stringifier {
  const Stringifier();

  const factory Stringifier.json({
    String identity,
    String lineBreak,
  }) = _JsonStringifier;

  const factory Stringifier.minimal({
    String identity,
    String lineBreak,
  }) = _MinimalStringifier;

  String stringify(Object object);
}

class _JsonStringifier extends Stringifier {
  final String identity;
  final String lineBreak;

  const _JsonStringifier({
    this.identity = ' ',
    this.lineBreak = '\n',
  });

  @override
  String stringify(Object object) => stringifyObject(object, identity: '');

  String stringifyObject(Object object, {required String identity}) {
    if (object is Stringify) {
      return '${object.runtimeType}${stringifyObject(object.toJson(), identity: identity)}';
    }
    final id = identity + this.identity;
    if (object is Iterable) {
      return stringifyCollection(object.map((object) {
        return stringifyObject(object, identity: id);
      }), start: '[', identity: identity, end: ']');
    }
    if (object is Map) {
      return stringifyCollection(object.entries.map((e) {
        return '"${e.key}": ${stringifyObject(e.value, identity: id)}';
      }), start: '{', identity: identity, end: '}');
    }
    return jsonEncode(object);
  }

  String stringifyCollection(
    Iterable<String> object, {
    required String start,
    required String identity,
    required String end,
  }) {
    final id = identity + this.identity;
    final data = object.map((object) => '$id$object').join(',$lineBreak');
    return '$start${data.isEmpty ? '' : '$lineBreak$data$lineBreak$id'}$end';
  }
}

class _MinimalStringifier extends Stringifier {
  final String identity;
  final String lineBreak;

  const _MinimalStringifier({
    this.identity = ' ',
    this.lineBreak = '\n',
  });

  @override
  String stringify(Object object) => stringifyObject(object, identity: '');

  String stringifyObject(Object object, {required String identity, String? name}) {
    final id = identity + this.identity;
    if (object is Stringify) {
      return stringifyObject(object.toJson(), name: '${object.runtimeType}', identity: identity);
    }
    if (object is List) {
      return stringifyCollection([
        for (int i = 0; i < object.length; i++) '$i. ${stringifyObject(object[i], identity: id)}',
      ], name: 'List', identity: identity);
    }
    if (object is Map) {
      return stringifyCollection(object.entries.map((e) {
        return '"${e.key}": ${stringifyObject(e.value, identity: id)}';
      }), name: name ?? 'Map', identity: identity);
    }
    return jsonEncode(object);
  }

  String stringifyCollection(
    Iterable<String> object, {
    required String name,
    required String identity,
  }) {
    final id = identity + this.identity;
    return '$name$lineBreak${object.map((object) => '$id$object').join(lineBreak)}';
  }
}
