import 'dart:convert';

import 'package:clarchtdd/core/error/exception.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia_cached.json")));

    test("Should return NumberTrivia from SharedPreferences when there is one",
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("trivia_cached.json"));
      //act
      final result = await dataSource.getLastNumberTrivia();
      //assert
      verify(mockSharedPreferences.getString(cachedTriviaNumber));
      expect(result, tNumberTriviaModel);
    });

    test("Should return CacheException when there is not cache value",
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getLastNumberTrivia;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheNumberTrivia", () {
    const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test text");
    final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
    test("Should call SharedPreferences to cache the data", () async {
      //arrange
      when(mockSharedPreferences.setString(
              cachedTriviaNumber, expectedJsonString))
          .thenAnswer((_) => Future.value(true) );
      //act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      //assert
      verify(mockSharedPreferences.setString(
          cachedTriviaNumber, expectedJsonString));
    });
  });
}
