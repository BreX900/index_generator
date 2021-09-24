import 'package:index_generator/src/stringify.dart';

abstract class Filter implements Stringify {
  final RegExp regExp;

  const Filter(this.regExp);

  factory Filter.fromJson(Map data) {
    final regExp = RegExp(data.values.single);
    switch (data.keys.single) {
      case 'white':
        return WhiteFilter(regExp);
      case 'black':
        return BlackFilter(regExp);
    }
    throw 'Not support filter, you can use only "black" or "white"';
  }

  @override
  Map<String, dynamic> toJson() {
    return {'filter($runtimeType)': regExp.pattern};
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
