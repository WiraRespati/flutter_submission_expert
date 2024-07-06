
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/watchlist_tv_series_bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  final tWatchlistTvSeriesList = <TvSeries>[tvSeries];

  test('initial state should be empty', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tWatchlistTvSeriesList));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(tWatchlistTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Error] when get watchlist tv series is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError('Database Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
  );
}
