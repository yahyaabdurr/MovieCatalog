import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvTopRatedMovies {
  final TvRepository repository;

  GetTvTopRatedMovies(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvTopRatedMovies();
  }
}
