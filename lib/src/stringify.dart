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
    this.identity = '  ',
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
    this.identity = '  ',
    this.lineBreak = '\n',
  });

  @override
  String stringify(Object? object) =>
      stringifyObject(object is Stringify, identity: '');

  String stringifyObject(
    Object? object, {
    required String identity,
    String? name,
  }) {
    final id = identity + this.identity;
    name ??= '${object.runtimeType}';
    if (object is Stringify) {
      return stringifyObject(object.toJson(), name: name, identity: identity);
    }
    if (object is List) {
      return stringifyCollection(
        {
          for (var i = 0; i < object.length; i++) '$i': object[i],
        },
        name: name,
        identity: id,
        separator: '.',
      );
    }
    if (object is Map) {
      return stringifyCollection(
        object,
        name: name,
        identity: id,
        separator: ':',
      );
    }
    return jsonEncode(object);
  }

  String stringifyCollection(
    Map<Object?, Object?> object, {
    required String name,
    required String identity,
    required String separator,
  }) {
    if (object.isEmpty) return name;
    return '$name$lineBreak${object.entries.map((e) {
      return '$identity${e.key}$separator ${stringifyObject(e.value, identity: identity)}';
    }).join(lineBreak)}';
  }
}
