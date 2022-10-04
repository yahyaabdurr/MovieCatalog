import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvMovieDetail getTvMovieDetail;
  final GetTvMovieRecommendations getTvMovieRecommendations;
  final GetWatchListStatus getTvWatchListStatus;
  final SaveTvWatchlist saveWatchlistTv;
  final RemoveTvWatchlist removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvMovieDetail,
    required this.getTvMovieRecommendations,
    required this.getTvWatchListStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late TvDetail _movie;
  TvDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<TvSeries> _movieRecommendations = [];
  List<TvSeries> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvMovieDetail.execute(id);
    final recommendationResult = await getTvMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tvMovie) async {
    final result = await saveWatchlistTv.execute(tvMovie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistTvStatus(movie.id);
  }

  Future<void> removeFromWatchlist(TvDetail tvMovie) async {
    final result = await removeWatchlistTv.execute(tvMovie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistTvStatus(movie.id);
  }

  Future<void> loadWatchlistTvStatus(int id) async {
    final result = await getTvWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
