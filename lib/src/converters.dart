import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';

class GlobJsonConverter extends JsonConverter<Glob, String> {
  const GlobJsonConverter();

  @override
  Glob fromJson(String json) => Glob(json, recursive: true);

  @override
  String toJson(Glob object) => object.pattern;
}
