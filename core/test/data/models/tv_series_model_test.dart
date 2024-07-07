import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    posterPath: 'posterPath',
    popularity: 5.4,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 9.4,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  const tTvSeries = TvSeries(
    posterPath: 'posterPath',
    popularity: 5.4,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 9.4,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of TV Series entity', () {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
