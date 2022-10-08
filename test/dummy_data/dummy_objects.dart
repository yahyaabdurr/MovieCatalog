import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeries = TvSeries(
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

final testTvSeriesDetail = TvDetail(
  originalLanguage: 'id',
  originCountry: ['a', 'b', 'c'],
  firstAirDate: 'firstAirdDate',
  originalName: 'originalName',
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  seasons: [
    Season(
        posterPath: 'posterPath',
        airDate: '2022-01-01',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        seasonNumber: 1)
  ],
);

final testTvSeriesList = [testTvSeries];

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvWatchlistMovie = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
