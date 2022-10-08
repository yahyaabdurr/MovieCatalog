import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';

import 'package:ditonton/domain/usecases/get_tv_popular_movies.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_popular_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvPopularMovies])
void main() {
  late MockGetTvPopularMovies mockGetTvPopularMovies;
  late TvPopularMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvPopularMovies = MockGetTvPopularMovies();
    notifier = TvPopularMoviesNotifier(mockGetTvPopularMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvPopularMovies.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    notifier.fetchTvPopularMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvPopularMovies.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    await notifier.fetchTvPopularMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvPopularMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvPopularMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
