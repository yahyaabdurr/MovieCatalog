import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  MovieSearchNotifier(
      {required this.searchMovies, required this.searchTvSeries});

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  RequestState _tvMovieState = RequestState.Empty;
  RequestState get tvMovieState => _tvMovieState;

  List<Movie> _searchMoviesResult = [];
  List<Movie> get searchMoviesResult => _searchMoviesResult;

  List<TvSeries> _searchTvSeriesResult = [];
  List<TvSeries> get searchTvSeriesResult => _searchTvSeriesResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _movieState = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _movieState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchMoviesResult = data;
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvMovieSearch(String query) async {
    _tvMovieState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _tvMovieState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchTvSeriesResult = data;
        _tvMovieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
