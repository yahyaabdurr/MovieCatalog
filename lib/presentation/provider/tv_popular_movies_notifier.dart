import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_tv_popular_movies.dart';

class TvPopularMoviesNotifier extends ChangeNotifier {
  final GetTvPopularMovies getTvPopularMovies;

  TvPopularMoviesNotifier(this.getTvPopularMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _movies = [];
  List<TvSeries> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopularMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
