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

    final segments = package.split(':');
    if (segments.length > 2) {
      throw 'Invalid package name: \'$package\'';
    } else if (segments.length == 1) {
      // TODO: Remove support on 4.0.0 version
      print('[WARNING]: Please change from \'$package\' to \'package:$package.dart\'');
      sb.write('package:$package.dart');
    } else {
      sb.write(package);
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
