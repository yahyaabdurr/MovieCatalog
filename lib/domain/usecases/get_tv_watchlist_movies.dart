import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../entities/tv_series.dart';

class GetWatchlistTvMovies {
  final TvRepository _repository;

  GetWatchlistTvMovies(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTv();
  }
}
