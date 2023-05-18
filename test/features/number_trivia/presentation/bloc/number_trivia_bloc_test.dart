import 'package:bloc_test/bloc_test.dart';
import 'package:clarchtdd/core/error/failure.dart';
import 'package:clarchtdd/core/usecases/usecase.dart';
import 'package:clarchtdd/core/utils/input_converter.dart';
import 'package:clarchtdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockInputConverter mockInputConverter;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test("initialState should be Empty", () {
    expect(bloc.state, equals(Empty()));
  });

  group("GetTriviaForConcreteNumberTrivia", () {
    const tNumberString = "1";
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: "Test Number");

    void setupMockInputConverterSucces() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));

    test(
        "Should call InputConverter to validate and convert the string to an unsigned integer",
        () async {
      //arrange
      setupMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(
          mockInputConverter.stringToUnsignedInteger(tNumberString));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('Should emit [Error] when the input is invalid ', () async* {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(tNumberString))
          .thenReturn(Left(InvalidInputFailure()));
      //assert later
      final expected = [Empty(), const Error(invalidInputFailureMessage)];
      expectLater(bloc.state, emitsInOrder(expected));
      //assert
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });


    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async* {
      //arrange
      setupMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //assert later
      final expected = [Empty(), Loading(), const Loaded(tNumberTrivia)];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

      test("Should emit [Loading, Error] when data failed",
        () async* {
      //arrange
      setupMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async =>  Left(ServerFailure()));
      //assert later
      final expected = [Empty(), Loading(), const Error(serverFailureMessage) ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });

    test("Should emit [Loading, Error] with a proper message for the error when getting data fails",
        () async* {
      //arrange
      setupMockInputConverterSucces();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async =>  Left(CacheFailure() ));
      //assert later
      final expected = [Empty(), Loading(), const Error(cacheFailureMessage) ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
    });
  });


    group("GetTriviaForRandomNumberTrivia", () {
    const tNumberTrivia = NumberTrivia(number: 1, text: "Test Number");


    test("Should get data from the random use case", () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //act
      bloc.add( GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));
      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      //assert later
      final expected = [Empty(), Loading(), const Loaded(tNumberTrivia)];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });

      test("Should emit [Loading, Error] when data failed",
        () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async =>  Left(ServerFailure()));
      //assert later
      final expected = [Empty(), Loading(), const Error(serverFailureMessage) ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });

    test("Should emit [Loading, Error] with a proper message for the error when getting data fails",
        () async* {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async =>  Left(CacheFailure() ));
      //assert later
      final expected = [Empty(), Loading(), const Error(cacheFailureMessage) ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
  });
}
