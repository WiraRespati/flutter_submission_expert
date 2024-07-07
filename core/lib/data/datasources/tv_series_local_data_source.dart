
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_series/tv_series_table.dart';
import 'package:core/utils/exception.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlistTvSeries(TvSeriesTable tvSeries);
  Future<String> removeWatchlistTvSeries(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
  Future<void> cacheNowPlayingTvSeries(List<TvSeriesTable> tvSeriess);
  Future<List<TvSeriesTable>> getCachedNowPlayingTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTvSeries(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvSeries(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlistTvSeries(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingTvSeries(List<TvSeriesTable> tvSeriess) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransactionTvSeries(
        tvSeriess, 'now playing');
  }

  @override
  Future<List<TvSeriesTable>> getCachedNowPlayingTvSeries() async {
    final result = await databaseHelper.getCacheTvSeries('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
