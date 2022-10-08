import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    this.adult,
    this.backdropPath,
    this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    required this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    this.popularity,
    this.posterPath,
    this.seasons,
    this.status,
    this.type,
    required this.voteAverage,
    this.voteCount,
  });
  final bool? adult;
  final String? backdropPath;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final String name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String? posterPath;
  final List<SeasonsModel>? seasons;
  final String? status;
  final String? type;
  final double voteAverage;
  final int? voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        episodeRunTime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"].map((x) => x))
            : null,
        firstAirDate: json['first_air_date'],
        homepage: json['homepage'],
        id: json['id'] ?? 0,
        inProduction: json['in_production'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        languages: List<String>.from(json["languages"].map((e) => e)),
        lastAirDate: json['last_air_date'],
        name: json['name'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originCountry: List.castFrom<dynamic, String>(json['origin_country']),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        seasons: List.from(json['seasons'])
            .map((e) => SeasonsModel.fromJson(e))
            .where((element) => element.posterPath != null)
            .toList(),
        status: json['status'],
        type: json['type'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['backdrop_path'] = backdropPath;
    _data['episode_run_time'] = episodeRunTime;
    _data['first_air_date'] = firstAirDate;
    _data['genres'] = genres.map((e) => e.toJson()).toList();
    _data['homepage'] = homepage;
    _data['id'] = id;
    _data['in_production'] = inProduction;
    _data['languages'] = languages;
    _data['last_air_date'] = lastAirDate;
    _data['name'] = name;
    _data['number_of_episodes'] = numberOfEpisodes;
    _data['number_of_seasons'] = numberOfSeasons;
    _data['origin_country'] = originCountry;
    _data['original_language'] = originalLanguage;
    _data['original_name'] = originalName;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['status'] = status;
    _data['type'] = type;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }

  TvDetail toEntity() {
    return TvDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      type: this.type,
      originalName: this.originalName,
      seasons: this.seasons?.map((season) => season.toEntity()).toList(),
      languages: this.languages,
      popularity: this.popularity,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      homepage: this.homepage,
      name: this.name,
      originalLanguage: this.originalLanguage,
      firstAirDate: this.firstAirDate,
      episodeRunTime: this.episodeRunTime,
      status: this.status,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      lastAirDate: this.lastAirDate,
      originCountry: this.originCountry,
      inProduction: this.inProduction,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        type,
        voteAverage,
        voteCount,
      ];
}
