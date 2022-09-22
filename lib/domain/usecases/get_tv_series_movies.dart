import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../common/failure.dart';

class GetTvSeriesMovies {
  final TvRepository repository;

  GetTvSeriesMovies(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvSeriesMovies();
  }
}
