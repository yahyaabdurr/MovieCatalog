import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated_movies.dart';

import 'package:ditonton/presentation/provider/tv_top_rated_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvTopRatedMovies])
void main() {
  late MockGetTvTopRatedMovies mockGetTvTopRatedMovies;
  late TvTopRatedMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvTopRatedMovies = MockGetTvTopRatedMovies();
    notifier = TvTopRatedMoviesNotifier(mockGetTvTopRatedMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvTopRatedMovies.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    notifier.fetchTvTopRatedMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvTopRatedMovies.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    await notifier.fetchTvTopRatedMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvTopRatedMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvTopRatedMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
