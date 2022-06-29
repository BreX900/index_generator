class DartExport {
  final String package;
  final List<String> show;
  final List<String> hide;

  const DartExport({
    required this.package,
    this.show = const [],
    this.hide = const [],
  });

  String toCode({StringBuffer? sb}) {
    sb ??= StringBuffer();

    sb.write('export \'');
    if (package.endsWith('.dart')) {
      sb.write(package);
    } else {
      // TODO: Remove support on 4.0.0 version
      print('[WARNING]: Please change from \'$package\' to \'package:$package.dart\'');
      sb.write('package:$package.dart');
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
