import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable movie);
  Future<String> removeWatchlistTv(TvTable movie);
  Future<TvTable?> getTvMovieById(int id);
  Future<List<TvTable>> getWatchlistTvMovies();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

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
