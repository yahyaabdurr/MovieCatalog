import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_tv_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_tv_series_movies.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_top_rated_movies.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;
  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  var _tvSeriesMovies = <TvSeries>[];
  List<TvSeries> get tvSeriesMovies => _tvSeriesMovies;

  RequestState _tvSeriesMoviesState = RequestState.Empty;
  RequestState get tvSeriesMoviesState => _tvSeriesMoviesState;

  var _tvSeriesPopularMovies = <TvSeries>[];
  List<TvSeries> get tvSeriesPopularMovies => _tvSeriesPopularMovies;

  RequestState _tvSeriesPopularMoviesState = RequestState.Empty;
  RequestState get tvSeriesPopularMoviesState => _tvSeriesPopularMoviesState;

  var _tvSeriesTopRatedMovies = <TvSeries>[];
  List<TvSeries> get tvSeriesTopRatedMovies => _tvSeriesTopRatedMovies;

  RequestState _tvSeriesTopRatedMoviesState = RequestState.Empty;
  RequestState get tvSeriesTopRatedMoviesState => _tvSeriesTopRatedMoviesState;

  String _message = '';
  String get message => _message;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getTvSeriesMovies,
    required this.getTvPopularMovies,
    required this.getTvTopRatedMovies,
  });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetTvSeriesMovies getTvSeriesMovies;
  final GetTvPopularMovies getTvPopularMovies;
  final GetTvTopRatedMovies getTvTopRatedMovies;
  Future<void> fetchTvSeriesMovies() async {
    _tvSeriesMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesMovies.execute();
    result.fold(
      (failure) {
        _tvSeriesMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _tvSeriesMoviesState = RequestState.Loaded;
        _tvSeriesMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvPopularMovies() async {
    _tvSeriesPopularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopularMovies.execute();
    result.fold(
      (failure) {
        _tvSeriesPopularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _tvSeriesPopularMoviesState = RequestState.Loaded;
        _tvSeriesPopularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvTopRatedMovies() async {
    _tvSeriesTopRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRatedMovies.execute();
    result.fold(
      (failure) {
        _tvSeriesTopRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _tvSeriesTopRatedMoviesState = RequestState.Loaded;
        _tvSeriesTopRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
