
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/usecase/get_watchlist_movies.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  final tWatchlistMoviesList = <Movie>[testWatchlistMovie];

  test('initial state should be empty', () {
    expect(watchlistMoviesBloc.state, WatchlistMoviesEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tWatchlistMoviesList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesHasData(tWatchlistMoviesList),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesEmpty(),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when get watchlist tv series is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      const WatchlistMoviesError('Database Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );
}
