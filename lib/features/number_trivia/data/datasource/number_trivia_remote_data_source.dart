import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {

  /// Throws [ServerException] error for all codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Throws [ServerException] error for all codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
