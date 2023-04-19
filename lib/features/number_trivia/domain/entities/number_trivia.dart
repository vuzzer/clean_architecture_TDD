import 'package:built_value/built_value.dart';
import 'package:clarchtdd/core/interfaces/trivia.dart';

part 'number_trivia.g.dart';


abstract class NumberTrivia implements Trivia, Built<NumberTrivia, NumberTriviaBuilder>  {

  // fields go here
  NumberTrivia._();

  factory NumberTrivia([void  Function(NumberTriviaBuilder) updates]) = _$NumberTrivia;


}
