class DartExport {
  final String library;
  final List<String> show;
  final List<String> hide;

  const DartExport({
    required this.library,
    this.show = const [],
    this.hide = const [],
  });

  String toCode({StringBuffer? sb}) {
    sb ??= StringBuffer();
    sb.write('export \'');

    if (library.endsWith('.dart')) {
      sb.write(library);
    } else {
      // TODO: Remove support on 4.0.0 version
      print(
          '[WARNING]: Please change from \'$library\' to \'package:$library.dart\'');
      sb.write('package:$library.dart');
    }
    sb.write('\'');

    if (show.isNotEmpty) {
      sb
        ..write(' show ')
        ..write(show.join(', '));
    }
    if (hide.isNotEmpty) {
      sb
        ..write(' hide ')
        ..write(hide.join(', '));
    }
    return (sb..write(';')).toString();
  }
}
