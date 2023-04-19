import 'package:clarchtdd/core/interfaces/trivia.dart';
import 'package:clarchtdd/core/platform/network_info.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clarchtdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clarchtdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;
  late MockNumberTriviaRemoteDataSource mockRemoteData;
  late MockNumberTriviaLocalDataSource mockLocalData;
  late MockNetworkInfo mockNetworkInfo;
  late int tNumber;
  late NumberTriviaModel tNumberTriviaModel;
  late Trivia tNumberTrivia;

  setUp(() {
    tNumber = 1;
    tNumberTriviaModel = NumberTriviaModel((b) => b
      ..number = tNumber
      ..text = "Test");
    tNumberTrivia = tNumberTriviaModel;
    mockRemoteData = MockNumberTriviaRemoteDataSource();
    mockLocalData = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteData,
        localDataSource: mockLocalData,
        networkInfo: mockNetworkInfo);
  });

  group("getConcreteNumberTrivia", () {});
}
