import 'package:clarchtdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clarchtdd/features/number_trivia/presentation/widget/widgets.dart';
import 'package:clarchtdd/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: BlocProvider(
          create: (_) => sl<NumberTriviaBloc>(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is Empty) {
                        return const MessageDisplay(message: "Start Searching");
                      } else if (state is Loading) {
                        return const LoadingWidget();
                      } else if (state is Loaded) {
                        return  TriviaDisplay(numberTrivia: state.trivia);
                      } else if (state is Error) {
                        return MessageDisplay(message: state.message);
                      }

                      // We're going to also check for the other states
                      return const Text("Text");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TriviaControls()
                ],
              ),
            ),
          )),
    );
  }
}
