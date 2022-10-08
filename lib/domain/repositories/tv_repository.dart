import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvSeries>>> getTvSeriesMovies();
  Future<Either<Failure, List<TvSeries>>> getTvPopularMovies();
  Future<Either<Failure, TvDetail>> getTvMovieDetail(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, List<TvSeries>>> getTvMovieRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tvMovie);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tvMovie);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}
