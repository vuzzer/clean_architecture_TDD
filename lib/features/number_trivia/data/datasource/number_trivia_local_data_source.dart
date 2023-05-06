import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clarchtdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia() {
    return Future.value(const NumberTriviaModel(text: "Test", number: 1));
  }

  Future<void> cacheNumberTrivia(NumberTrivia triviaModel);
}
