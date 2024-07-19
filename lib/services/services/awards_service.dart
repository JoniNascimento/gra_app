import 'package:dio/dio.dart';
import 'package:gra_app/services/domain/entities/awards_interval_producers.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/domain/entities/studio_winners.dart';
import 'package:gra_app/services/domain/entities/year_winners.dart';
import 'package:logging/logging.dart';

class AwardsService {
  final Dio _dio;
  final Logger _logger;
  AwardsService(this._dio, this._logger);

  Future<AwardsIntervalProducers> getIntervalAwards() async {
    try {
      final response =
          await _dio.get('?projection=max-min-win-interval-for-producers');
      return AwardsIntervalProducers.fromMap(response.data);
    } on DioException catch (dioException) {
      _logger.severe(
        dioException.message,
        dioException.error,
        StackTrace.current,
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(e, null, stackTrace);
      rethrow;
    }
  }

  Future<List<MovieEntity>> getMovieWinners(String year) async {
    try {
      final response = await _dio.get('?page=9&size=99&winner=true&year=$year');
      return (response.data as List)
          .map((e) => MovieEntity.fromMap(e))
          .toList();
    } on DioException catch (dioException) {
      _logger.severe(
        dioException.message,
        dioException.error,
        StackTrace.current,
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(e, null, stackTrace);
      rethrow;
    }
  }

  Future<List<StudioWinners>> getStudioWinners() async {
    try {
      final response = await _dio.get('?projection=studios-with-win-count');
      final List<dynamic> responseBody = response.data['studios'];
      return List.generate(
          3, (index) => StudioWinners.fromMap(responseBody[index]));
    } on DioException catch (dioException) {
      _logger.severe(
        dioException.message,
        dioException.error,
        StackTrace.current,
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(e, null, stackTrace);
      rethrow;
    }
  }

  Future<List<YearWinners>> getYearWinners() async {
    try {
      final response =
          await _dio.get('?projection=years-with-multiple-winners');
      final List<dynamic> responseBody = response.data['years'];
      return List.generate(responseBody.length,
          (index) => YearWinners.fromMap(responseBody[index]));
    } on DioException catch (dioException) {
      _logger.severe(
        dioException.message,
        dioException.error,
        StackTrace.current,
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(e, null, stackTrace);
      rethrow;
    }
  }

  Future<List<MovieEntity>> getMovieWinnersByYear(
      {String? year, required bool winners}) async {
    try {
      final response = await _dio.get('?winner=$winners&year=$year');
      final List<dynamic> responseBody = response.data;
      return List.generate(responseBody.length,
          (index) => MovieEntity.fromMap(responseBody[index]));
    } on DioException catch (dioException) {
      _logger.severe(
        dioException.message,
        dioException.error,
        StackTrace.current,
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.severe(e, null, stackTrace);
      rethrow;
    }
  }
}
