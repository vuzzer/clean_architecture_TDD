import 'package:built_value/built_value.dart';

part 'trivia.g.dart';

@BuiltValue(instantiable: false)
abstract class Trivia extends Object {

  int get number;
  String get text;

  Trivia rebuild(void Function(TriviaBuilder) updates);
  TriviaBuilder toBuilder();
}
