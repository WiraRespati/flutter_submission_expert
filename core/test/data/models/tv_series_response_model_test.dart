import 'dart:convert';
import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/data/models/tv_series/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test/json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    posterPath: '/path.jpg',
    popularity: 3.4,
    id: 1,
    backdropPath: '/path.jpg',
    voteAverage: 9.0,
    overview: 'Overview',
    firstAirDate: "2023-12-12",
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'Original Language',
    voteCount: 160,
    name: 'Name',
    originalName: 'Original Name',
  );

  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/now_playing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path.jpg",
            "popularity": 3.4,
            "id": 1,
            "backdrop_path": "/path.jpg",
            "vote_average": 9.0,
            "overview": "Overview",
            "first_air_date": "2023-12-12",
            "origin_country": ["en", "id"],
            "genre_ids": [1, 2, 3],
            "original_language": "Original Language",
            "vote_count": 160,
            "name": "Name",
            "original_name": "Original Name"
          }
        ],
      };
      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
