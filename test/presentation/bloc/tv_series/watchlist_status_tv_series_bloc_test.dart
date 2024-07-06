import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/watchlist_status_tv_series_bloc/watchlist_status_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_objects.dart';
import 'watchlist_status_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late WatchlistStatusTvSeriesBloc watchlistStatusTvSeriesBloc;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    watchlistStatusTvSeriesBloc = WatchlistStatusTvSeriesBloc(
      getWatchListStatusTvSeries: mockGetWatchListStatusTvSeries,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  const tId = 1;

  group('Watchlist Status TV Series', () {
    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Should emit [WatchlistStatusState] when get watchlist status true',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusTvSeries(tId)),
      expect: () => [
        const WatchlistStatusTvSeriesState(
            isAddedToWatchlist: true, message: ''),
      ],
    );
  });

  group('Save Watchlist TV Series', () {
    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Should emit [WatchlistStatusState] when data is saved',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(tvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistTvSeries(tvSeriesDetail)),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: true,
          message: 'Added to Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockSaveWatchlistTvSeries.execute(tvSeriesDetail)),
        verify(mockGetWatchListStatusTvSeries.execute(tId)),
      ],
    );

    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Should emit [WatchlistStatusState] when save data is unsuccessful',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(tvSeriesDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('Failed Added to Watchlist')));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistTvSeries(tvSeriesDetail)),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: 'Failed Added to Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockSaveWatchlistTvSeries.execute(tvSeriesDetail)),
        verify(mockGetWatchListStatusTvSeries.execute(tId)),
      ],
    );
  });

  group('Remove Watchlist TV Series', () {
    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Should emit [WatchlistStatusState] when data is removed',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(tvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchlistTvSeries(tvSeriesDetail)),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: 'Removed from Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockRemoveWatchlistTvSeries.execute(tvSeriesDetail)),
        verify(mockGetWatchListStatusTvSeries.execute(tId)),
      ],
    );

    blocTest<WatchlistStatusTvSeriesBloc, WatchlistStatusTvSeriesState>(
      'Should emit [WatchlistStatusState] when remove data is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(tvSeriesDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('Failed Removed from Watchlist')));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchlistTvSeries(tvSeriesDetail)),
      expect: () => [
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: true,
          message: 'Failed Removed from Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockRemoveWatchlistTvSeries.execute(tvSeriesDetail)),
        verify(mockGetWatchListStatusTvSeries.execute(tId)),
      ],
    );
  });
}

