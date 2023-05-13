import 'dart:convert';

import 'package:clarchtdd/core/error/exception.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedTriviaNumber = "CACHED_NUMBER_TRIVIA";

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia() {
    return Future.value(const NumberTriviaModel(text: "Test", number: 1));
  }

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  SharedPreferences preferences;
  NumberTriviaLocalDataSourceImpl(this.preferences);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel) {
    return preferences.setString(
        cachedTriviaNumber, json.encode(triviaModel.toJson() ));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = preferences.getString(cachedTriviaNumber);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }
    throw CacheException();
  }
}
