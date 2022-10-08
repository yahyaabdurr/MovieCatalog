import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesMovies usecase;
  late MockTvRepository mockTvMovieRepository;

  setUp(() {
    mockTvMovieRepository = MockTvRepository();
    usecase = GetTvSeriesMovies(mockTvMovieRepository);
  });

  final tMovies = <TvSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvMovieRepository.getTvSeriesMovies())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
