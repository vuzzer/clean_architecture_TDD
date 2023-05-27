import 'dart:async';

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
        emit(Loading());

        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);

        await Future<void>.delayed(
          const Duration(seconds: 2),
        );


        await inputEither.fold((failure) {
          emit(const Error(invalidInputFailureMessage));
        }, (integer) async {
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          await _eitherLoadedOrErrorState(failureOrTrivia, emit);
        });
      } else if (event is GetTriviaForRandomNumber) {
        emit(Loading());
        final failureOrTrivia = await getRandomNumberTrivia(NoParams());
        await _eitherLoadedOrErrorState(failureOrTrivia, emit);
      }
    });
  }

  Future<void> _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivia> either, Emitter emit) async {
    either.fold((failure) => emit(Error(_mapFailureToMessage(failure))),
        (trivia) => emit(Loaded(trivia)));
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
