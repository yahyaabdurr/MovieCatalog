import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvTopRatedMovies usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvTopRatedMovies(mockTvRepository);
  });

  final tMovies = <TvSeries>[];

  group('Get Tv Top Rated Movies', () {
    group('execute', () {
      test(
          'should get list of tv series top rated from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getTvTopRatedMovies())
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
