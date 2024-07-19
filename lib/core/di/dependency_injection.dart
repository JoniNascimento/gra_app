import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gra_app/core/network/dio_options.dart';
import 'package:gra_app/services/services/awards_service.dart';
import 'package:logging/logging.dart';

final GetIt inject = GetIt.instance;

void setupInjection() {

  final logger = Logger('Meu Logger')..level = Level.ALL;

  inject
    ..registerLazySingleton(() => logger)
    ..registerLazySingleton<Dio>(() => Dio( BuildBaseOptions().buildBaseUrl().buildCommonHeaders().build()))
    ..registerLazySingleton<AwardsService>(() => AwardsService(inject.get<Dio>(), inject.get<Logger>()));
}