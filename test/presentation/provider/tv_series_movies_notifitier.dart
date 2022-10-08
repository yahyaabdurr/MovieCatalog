import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_movies.dart';

import 'package:ditonton/presentation/provider/tv_series_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tv_series_movies_notifitier.mocks.dart';

@GenerateMocks([GetTvSeriesMovies])
void main() {
  late MockGetTvSeriesMovies mockGetTvSeriesMovies;
  late TvSeriesMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesMovies = MockGetTvSeriesMovies();
    notifier = TvSeriesMoviesNotifier(mockGetTvSeriesMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvSeriesMovies.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    notifier.fetchTvSeriesMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvSeriesMovies.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    await notifier.fetchTvSeriesMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeriesMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSeriesMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
