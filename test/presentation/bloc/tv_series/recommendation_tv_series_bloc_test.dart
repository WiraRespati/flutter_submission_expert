
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series/recommendation_tv_series_bloc/recommendation_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_objects.dart';
import 'recommendation_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late RecommendationTvSeriesBloc recommendationTvSeriesBloc;
  late MockGetTvSeriesRecommendations mockGetRecommendationTvSeries;

  setUp(() {
    mockGetRecommendationTvSeries = MockGetTvSeriesRecommendations();
    recommendationTvSeriesBloc =
        RecommendationTvSeriesBloc(mockGetRecommendationTvSeries);
  });

  const tId = 1;
  final tTvSeriesList = <TvSeries>[tvSeries];

  test('initial state should be empty', () {
    expect(recommendationTvSeriesBloc.state, RecommendationTvSeriesEmpty());
  });

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvSeries.execute(tId)),
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvSeries.execute(tId)),
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, Error] when get recommendations tv series is unsuccessful',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(tId)),
    expect: () => [
      RecommendationTvSeriesLoading(),
      const RecommendationTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvSeries.execute(tId)),
  );
}
