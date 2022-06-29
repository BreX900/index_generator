class Utils {
  /// Used to split a comments or docs to a lines without first and last empty lines
  static List<String> parseTextLines(String source) {
    return source
        .split('\n')
        .map((line) => line.trim()) // Clean lines
        .skipWhile((line) => line.isEmpty) // Ignore first empty lines
        .reverse()
        .skipWhile((line) => line.isEmpty) // Ignore last empty lines
        .reverse()
        .toList();
  }
}

extension<T> on Iterable<T> {
  Iterable<T> reverse() => toList(growable: false).reversed;
}
