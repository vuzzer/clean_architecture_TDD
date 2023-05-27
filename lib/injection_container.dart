import 'package:clarchtdd/core/network/network_info.dart';
import 'package:clarchtdd/core/utils/input_converter.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clarchtdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clarchtdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clarchtdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clarchtdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  //Use cases
  sl.registerLazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(sl()));

  //Repositories
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Data Sources
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferencies = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferencies);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
