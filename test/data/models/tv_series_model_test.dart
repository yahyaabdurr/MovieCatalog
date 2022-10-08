import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvSeriesModel = TvSeriesModel(
    originalLanguage: 'id',
    originCountry: ['a', 'b', 'c'],
    firstAirDate: 'firstAirdDate',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tvSeries = TvSeries(
    originalLanguage: 'id',
    originCountry: ['a', 'b', 'c'],
    firstAirDate: 'firstAirdDate',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });
}
