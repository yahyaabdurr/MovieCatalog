import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvMovies usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvMovies(mockTvRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}
