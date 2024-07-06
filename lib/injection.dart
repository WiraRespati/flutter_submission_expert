import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/seach_tv_series.dart';
import 'package:ditonton/presentation/bloc/movie/detail_movie_bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc/pupular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation_movie_bloc/recommendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search_movie_bloc/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_status_movie_bloc/watchlist_status_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/detail_tv_series_bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series_bloc/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/recommendation_tv_series_bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/search_tv_series_bloc/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/watchlist_status_tv_series_bloc/watchlist_status_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/watchlist_tv_series_bloc/watchlist_tv_series_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));
  locator.registerFactory(() => WatchlistStatusMovieBloc(
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => SearchMovieBloc(locator()));

  locator.registerFactory(() => NowPlayingTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => DetailTvSeriesBloc(locator()));
  locator.registerFactory(() => RecommendationTvSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistTvSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistStatusTvSeriesBloc(
        getWatchListStatusTvSeries: locator(),
        saveWatchlistTvSeries: locator(),
        removeWatchlistTvSeries: locator(),
      ));
  locator.registerFactory(() => SearchTvSeriesBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
