import 'dart:convert';
import 'dart:math';

import 'package:clarchtdd/core/interfaces/trivia.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final NumberTriviaModel tNumberTriviaModel;

  setUpAll(() {
    tNumberTriviaModel = NumberTriviaModel((b) => b
      ..number = 1
      ..text = "Test Text");
  });

  test("Should be a subclass of NumberTrivia entitiy", () async {
    //assert
    expect(tNumberTriviaModel, isA<Trivia>());
  });

  group("fromJson", () {
    test("Should return a valid model when the JSON number is an integer",
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, tNumberTriviaModel);
    });
    test(
        "Should return a valid model when the JSON number is regarded as a double",
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("trivia_double.json"));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, tNumberTriviaModel);
    });
  });

  group("toJson", () {
    test("should return a JSON map containing the proper data", () async {
      //act
      final result = tNumberTriviaModel.toJson();
      //arrange
      final expecteJsonMap = {
        "text": "Test Text",
        "number": 1,
      };
      //assert
      expect(result, expecteJsonMap);
    });
  });
}
