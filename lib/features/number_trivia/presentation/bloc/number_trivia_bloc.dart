import 'package:clarchtdd/core/error/failure.dart';
import 'package:clarchtdd/core/interfaces/trivia.dart';
import 'package:clarchtdd/core/usecases/usecase.dart';
import 'package:clarchtdd/core/utils/input_converter.dart';
import 'package:clarchtdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);

        inputEither.fold((failure) async* {
          yield const Error(invalidInputFailureMessage);
        }, (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          _eitherLoadedOrErrorState(failureOrTrivia);
        });
      } else if (event is GetTriviaForRandomNumber) {
        final failureOrTrivia = await getRandomNumberTrivia(NoParams());
        _eitherLoadedOrErrorState(failureOrTrivia);
      }
    });
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivia> either) async* {
    yield either.fold((failure) => Error(_mapFailureToMessage(failure)),
        (trivia) => Loaded(trivia));
  }

  String _mapFailureToMessage(failure) {
    switch (failure) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
