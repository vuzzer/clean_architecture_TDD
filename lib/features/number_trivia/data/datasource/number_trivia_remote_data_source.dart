import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Throws [ServerException] error for all codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
     //Use for test
    return Future.value(NumberTriviaModel(text: "Test", number: number));
  }

  /// Throws [ServerException] error for all codes
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    //Use for test
   return Future.value(const NumberTriviaModel(number: 1, text: "Test"));
  }
}
