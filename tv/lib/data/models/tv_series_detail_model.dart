import 'package:equatable/equatable.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/seasons_model.dart';

import '../../domain/entities/tv_detail.dart';

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
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['episode_run_time'] = episodeRunTime;
    data['first_air_date'] = firstAirDate;
    data['genres'] = genres.map((e) => e.toJson()).toList();
    data['homepage'] = homepage;
    data['id'] = id;
    data['in_production'] = inProduction;
    data['languages'] = languages;
    data['last_air_date'] = lastAirDate;
    data['name'] = name;
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['status'] = status;
    data['type'] = type;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  TvDetail toEntity() {
    return TvDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      type: type,
      originalName: originalName,
      seasons: seasons?.map((season) => season.toEntity()).toList(),
      languages: languages,
      popularity: popularity,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      homepage: homepage,
      name: name,
      originalLanguage: originalLanguage,
      firstAirDate: firstAirDate,
      episodeRunTime: episodeRunTime,
      status: status,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      lastAirDate: lastAirDate,
      originCountry: originCountry,
      inProduction: inProduction,
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
