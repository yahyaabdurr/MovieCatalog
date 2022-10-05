import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_tv_watchlist_movies.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  var _watchlistTvMovies = <TvSeries>[];
  List<Movie> get watchlistMovies => _watchlistMovies;
  List<TvSeries> get watchlistTvMovies => _watchlistTvMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  var _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier(
      {required this.getWatchlistMovies, required this.getWatchlistTvMovies});

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvMovies getWatchlistTvMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvMovies() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvMovies.execute();
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistTvState = RequestState.Loaded;
        _watchlistTvMovies = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
