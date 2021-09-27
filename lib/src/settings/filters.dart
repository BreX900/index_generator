import 'package:glob/glob.dart';
import 'package:index_generator/src/stringify.dart';

abstract class Filter implements Stringify {
  final Glob glob;

  const Filter(this.glob);

  factory Filter.fromJson(Map data) {
    final glob = Glob(data.values.single);
    switch (data.keys.single) {
      case 'white':
        return WhiteFilter(glob);
      case 'black':
        return BlackFilter(glob);
    }
    throw 'Not support filter, you can use only "black" or "white"';
  }

  @override
  Map<String, dynamic> toJson() {
    return {'filter($runtimeType)': glob.pattern};
  }

  bool accept(String path);

  @override
  String toString();
}

class WhiteFilter extends Filter {
  WhiteFilter(Glob glob) : super(glob);

  @override
  bool accept(String path) => glob.matches(path);

  @override
  String toString() => 'WhiteFilter(${glob.pattern})';
}

class BlackFilter extends Filter {
  BlackFilter(Glob glob) : super(glob);

  @override
  bool accept(String path) => !glob.matches(path);

  @override
  String toString() => 'BlackFilter(${glob.pattern})';
}
