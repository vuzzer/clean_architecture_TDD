import 'package:clarchtdd/core/error/exception.dart';
import 'package:clarchtdd/core/error/failure.dart';
import 'package:clarchtdd/core/network/network_info.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clarchtdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clarchtdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaRemoteDataSource mockRemoteData;
  late MockNumberTriviaLocalDataSource mockLocalData;
  late MockNetworkInfo mockNetworkInfo;
  late int tNumber;

  setUp(() {
    tNumber = 1;
    mockRemoteData = MockNumberTriviaRemoteDataSource();
    mockLocalData = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteData,
        localDataSource: mockLocalData,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group("device is online", () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
      body();
    });
  }

  void runTestsOffline(Function body) {
    group("device is offline", () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));
      body();
    });
  }

  group("getConcreteNumberTrivia", () {
    tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: "Test");
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    runTestsOnline(() {
      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        //arrange
        when(mockRemoteData.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteData.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalData);
        expect(result, equals(left(ServerFailure())));
      });

      test(
          "should cache the data locally when the call to remote data source is successful",
          () async {
        //arrange
        when(mockRemoteData.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteData.getConcreteNumberTrivia(tNumber));
        verify(mockLocalData.cacheNumberTrivia(tNumberTrivia));
        expect(result, equals(right(tNumberTrivia)));
      });
    });

    runTestsOffline(() {
      test("should return CacheFailure when there is no data cached", () async {
        //arrange
        when(mockLocalData.getLastNumberTrivia()).thenThrow(CacheException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockLocalData.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteData);
        expect(result, equals(left(CacheFailure())));
      });

      test(
          "should return last locally cached data when the cached data is present",
          () async {
        //arrange
        when(mockLocalData.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockLocalData.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteData);
        expect(result, equals(right(tNumberTrivia)));
      });
    });
  });

  group("getRandomNumberTrivia", () {
    tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: "Test");
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    runTestsOnline(() {
      test(
          "should cache the data locally when the call to remote data source is RandomNumber and successful",
          () async {
        //arrange
        when(mockRemoteData.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteData.getRandomNumberTrivia());
        verify(mockLocalData.cacheNumberTrivia(tNumberTrivia));
        expect(result, equals(right(tNumberTrivia)));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        //arrange
        when(mockRemoteData.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteData.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalData);
        expect(result, equals(left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("should return CacheFailure when there is no data cached", () async {
        //arrange
        when(mockLocalData.getLastNumberTrivia()).thenThrow(CacheException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockLocalData.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteData);
        expect(result, equals(left(CacheFailure())));
      });

      test(
          "should return last locally cached data when the cached data is present - RandomNumber",
          () async {
        //arrange
        when(mockLocalData.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockLocalData.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteData);
        expect(result, equals(right(tNumberTrivia)));
      });
    });
  });
}
