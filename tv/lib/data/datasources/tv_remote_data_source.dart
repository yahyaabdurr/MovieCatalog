import 'dart:convert';
import 'package:core/utils/exception.dart';
import 'package:http/http.dart' as http;
import '../models/tv_series_detail_model.dart';
import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getTvSeriesMovies();
  Future<List<TvSeriesModel>> getTvPopularMovies();
  Future<List<TvSeriesModel>> getTvTopRatedMovies();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvMovieRecommendations(int id);
  Future<List<TvSeriesModel>> searchTvMovies(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const TV = "tv";

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getTvSeriesMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/$TV/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvPopularMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/$TV/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/$TV/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/$TV/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/$TV/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/$TV?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
