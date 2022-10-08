import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_tv_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_tv_series_movies.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetTvSeriesMovies,
  GetTvPopularMovies,
])
void main() {
  late MovieListNotifier provider;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetTvSeriesMovies mockGetTvSeriesMovies;
  late MockGetTvPopularMovies mockGetTvPopularMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetTvSeriesMovies = MockGetTvSeriesMovies();
    mockGetTvPopularMovies = MockGetTvPopularMovies();
    provider = MovieListNotifier(
        getNowPlayingMovies: mockGetNowPlayingMovies,
        getPopularMovies: mockGetPopularMovies,
        getTopRatedMovies: mockGetTopRatedMovies,
        getTvSeriesMovies: mockGetTvSeriesMovies,
        getTvPopularMovies: mockGetTvPopularMovies)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      verify(mockGetNowPlayingMovies.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchPopularMovies();
      // assert
      expect(provider.popularMoviesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchPopularMovies();
      // assert
      expect(provider.popularMoviesState, RequestState.Loaded);
      expect(provider.popularMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularMovies();
      // assert
      expect(provider.popularMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('tv popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvPopularMovies.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      provider.fetchTvPopularMovies();
      // assert
      expect(provider.tvSeriesPopularMoviesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTvPopularMovies.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await provider.fetchTvPopularMovies();
      // assert
      expect(provider.tvSeriesPopularMoviesState, RequestState.Loaded);
      expect(provider.tvSeriesPopularMovies, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvPopularMovies();
      // assert
      expect(provider.tvSeriesPopularMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loaded);
      expect(provider.topRatedMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
