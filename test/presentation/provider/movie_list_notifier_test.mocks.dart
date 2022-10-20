// Mocks generated by Mockito 5.2.0 from annotations
// in ditonton/test/presentation/provider/movie_list_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/domain/entities/movie.dart' as _i8;
import 'package:ditonton/domain/entities/tv_series.dart' as _i12;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i4;
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart' as _i5;
import 'package:ditonton/domain/usecases/get_popular_movies.dart' as _i9;
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart' as _i10;
import 'package:ditonton/domain/usecases/get_tv_popular_movies.dart' as _i13;
import 'package:ditonton/domain/usecases/get_tv_series_movies.dart' as _i11;
import 'package:ditonton/domain/usecases/get_tv_top_rated_movies.dart' as _i14;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeTvRepository_2 extends _i1.Fake implements _i4.TvRepository {}

/// A class which mocks [GetNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingMovies extends _i1.Mock
    implements _i5.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularMovies extends _i1.Mock implements _i9.GetPopularMovies {
  MockGetPopularMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [GetTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMovies extends _i1.Mock implements _i10.GetTopRatedMovies {
  MockGetTopRatedMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [GetTvSeriesMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvSeriesMovies extends _i1.Mock implements _i11.GetTvSeriesMovies {
  MockGetTvSeriesMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_2()) as _i4.TvRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_1<_i7.Failure, List<_i12.TvSeries>>()))
          as _i6.Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>>);
}

/// A class which mocks [GetTvPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvPopularMovies extends _i1.Mock
    implements _i13.GetTvPopularMovies {
  MockGetTvPopularMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_2()) as _i4.TvRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_1<_i7.Failure, List<_i12.TvSeries>>()))
          as _i6.Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>>);
}

/// A class which mocks [GetTvTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvTopRatedMovies extends _i1.Mock
    implements _i14.GetTvTopRatedMovies {
  MockGetTvTopRatedMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_2()) as _i4.TvRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>>.value(
                      _FakeEither_1<_i7.Failure, List<_i12.TvSeries>>()))
          as _i6.Future<_i3.Either<_i7.Failure, List<_i12.TvSeries>>>);
}
