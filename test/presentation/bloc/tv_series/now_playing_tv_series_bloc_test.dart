
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series_bloc/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_objects.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
  });

  final tTvSeriesList = <TvSeries>[tvSeries];

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten succesfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'Should emit [Loading, Error] when get now playing tv series is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      const NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
  );
}
