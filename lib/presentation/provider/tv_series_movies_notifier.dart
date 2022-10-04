import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

import 'package:ditonton/domain/usecases/get_tv_series_movies.dart';
import 'package:flutter/foundation.dart';

class TvSeriesMoviesNotifier extends ChangeNotifier {
  final GetTvSeriesMovies getTvSeriesMovies;

  TvSeriesMoviesNotifier({required this.getTvSeriesMovies});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _movies = [];
  List<TvSeries> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesMovies.execute();

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
