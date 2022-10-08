import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();

  Future<String> insertWatchlistTv(TvTable movie);
  Future<String> removeWatchlistTv(TvTable movie);
  Future<TvTable?> getTvMovieById(int id);
  Future<List<TvTable>> getWatchlistTvMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistTv(TvTable movie) async {
    try {
      await databaseHelper.insertWatchlistTv(movie);
      return 'Added Tv Series to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable movie) async {
    try {
      await databaseHelper.removeWatchlistTv(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvMovieById(int id) async {
    final result = await databaseHelper.getTvMovieById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvMovies() async {
    final result = await databaseHelper.getWatchlistTvMovies();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
