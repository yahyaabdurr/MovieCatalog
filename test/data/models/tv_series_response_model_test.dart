import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tvSeriesMovieModel = TvSeriesModel(
      originalLanguage: 'en',
      originCountry: ['US'],
      firstAirDate: '2022-09-01',
      originalName: 'The Lord of the Rings: The Rings of Power',
      backdropPath: '/1rO4xoCo4Z5WubK0OwdVll3DPYo.jpg',
      genreIds: [10765, 10759, 18],
      id: 84773,
      overview:
          'Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.',
      popularity: 4751.07,
      posterPath: '/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg',
      name: 'The Lord of the Rings: The Rings of Power',
      voteAverage: 7.7,
      voteCount: 893);
  final tvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tvSeriesMovieModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/1rO4xoCo4Z5WubK0OwdVll3DPYo.jpg",
            "first_air_date": "2022-09-01",
            "genre_ids": [10765, 10759, 18],
            "id": 84773,
            "name": "The Lord of the Rings: The Rings of Power",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "The Lord of the Rings: The Rings of Power",
            "overview":
                "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
            "popularity": 4751.07,
            "poster_path": "/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg",
            "vote_average": 7.7,
            "vote_count": 893
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
