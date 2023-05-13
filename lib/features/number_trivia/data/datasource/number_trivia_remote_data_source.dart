import 'dart:convert';

import 'package:clarchtdd/core/error/exception.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Throws [ServerException] error for all codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    //Use for test
    return Future.value(NumberTriviaModel(text: "Test", number: number));
  }

  /// Throws [ServerException] error for all codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client httpClient;
  NumberTriviaRemoteDataSourceImpl(this.httpClient);
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl("http://numbersapi.com/$number");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl("http://numbersapi.com/random");

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await httpClient
        .get(Uri.parse(url), headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }
    throw ServerException();
  }
}
