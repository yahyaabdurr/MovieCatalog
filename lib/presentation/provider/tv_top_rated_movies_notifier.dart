import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated_movies.dart';

import 'package:flutter/foundation.dart';

class TvTopRatedMoviesNotifier extends ChangeNotifier {
  final GetTvTopRatedMovies getTvTopRatedMovies;

  TvTopRatedMoviesNotifier(this.getTvTopRatedMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _movies = [];
  List<TvSeries> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvTopRatedMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRatedMovies.execute();

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
