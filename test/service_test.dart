import 'package:dio/dio.dart';
import 'package:gra_app/services/domain/entities/awards_interval_producers.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/domain/entities/producer_winners.dart';
import 'package:gra_app/services/domain/entities/studio_winners.dart';
import 'package:gra_app/services/domain/entities/year_winners.dart';
import 'package:gra_app/services/services/awards_service.dart';
import 'package:logging/logging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks para Dio e Logger
class MockDio extends Mock implements Dio {}

class MockLogger extends Mock implements Logger {}

class MockRequestOptions extends Mock implements RequestOptions {}

void main() {
  late AwardsService awardsService;
  late MockDio mockDio;
  late MockLogger mockLogger;

  setUp(() {
    mockDio = MockDio();
    mockLogger = MockLogger();
    awardsService = AwardsService(mockDio, mockLogger);
  });

  group('getIntervalAwards', () {
    test('Retorna uma instancia de AwardsIntervalProducers', () async {
      final response = Response(
        data: {
          "min": [
            {
              "producer": "Producer Name",
              "interval": 9,
              "previousWin": 2018,
              "followingWin": 2019
            }
          ],
          "max": [
            {
              "producer": "Producer Name",
              "interval": 99,
              "previousWin": 1900,
              "followingWin": 1999
            }
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => mockDio.get(any())).thenAnswer((_) async {
        return response;
      });
      final result = await awardsService.getIntervalAwards();

      expect(result, isA<AwardsIntervalProducers>());
      expect(result.max, isA<List<ProducerWinners>>());
      expect(result.min, isA<List<ProducerWinners>>());
    });

    test('Exibe uma excesão se o servidor retornar um erro', () async {
      when(() => mockDio.get(any()))
          .thenThrow(DioException(requestOptions: MockRequestOptions()));
      expect(() => awardsService.getIntervalAwards(), throwsException);
      verify(() => mockLogger.severe(any(), any(), any())).called(1);
    });
  });

  group('getMovieWinnersByYear', () {
    test('Retorna uma lista de MovieWinners', () async {
      final response = Response(
        data: [
          {
            "id": 99,
            "year": 1990,
            "title": "Movie Title",
            "studios": ["Studio Name"],
            "producers": [" Producer Name "],
            "winner": true
          },
          {
            "id": 99,
            "year": 1990,
            "title": "Movie Title",
            "studios": ["Studio Name"],
            "producers": [" Producer Name "],
            "winner": true
          }
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => mockDio.get(any())).thenAnswer((_) async {
        return response;
      });
      final result = await awardsService.getMovieWinners('1990');

      expect(result, isA<List<MovieEntity>>());
    });
  });

  group('getYearWinners', () {
    test('Retorna uma lista de anos com mais vencedores', () async {
      final response = Response(
        data: {
          "years": [
            {"year": 9999, "winnerCount": 99},
            {"year": 9999, "winnerCount": 99}
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => mockDio.get(any())).thenAnswer((_) async {
        return response;
      });
      final result = await awardsService.getYearWinners();

      expect(result, isA<List<YearWinners>>());
    });
  });
  group('getStudioWinners', () {
    test('Retorna uma lista de Studios com mais vencedores', () async {
      final response = Response(
        data: {
          "studios": [
            {"name": "Studio Name", "winCount": 9},
            {"name": "Studio Name", "winCount": 9},
            {"name": "Studio Name", "winCount": 9}
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => mockDio.get(any())).thenAnswer((_) async {
        return response;
      });
      final result = await awardsService.getStudioWinners();

      expect(result, isA<List<StudioWinners>>());
    });
  });
}
