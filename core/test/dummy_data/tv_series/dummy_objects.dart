import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_series/season_model.dart';
import 'package:core/data/models/tv_series/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/data/models/tv_series/tv_series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

const watchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const tvSeriesModel = TvSeriesModel(
  posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
  popularity: 227.486,
  id: 84958,
  backdropPath: '/q3jHCb4dMfYF6ojikKuHd6LscxC.jpg',
  voteAverage: 8.18,
  overview:
      'After stealing the Tesseract during the events of “Avengers: Endgame,” an alternate version of Loki is brought to the mysterious Time Variance Authority, a bureaucratic organization that exists outside of time and space and monitors the timeline. They give Loki a choice: face being erased from existence due to being a “time variant” or help fix the timeline and stop a greater threat.',
  firstAirDate: '2021-06-09',
  originCountry: ['US'],
  genreIds: [18, 10765],
  originalLanguage: 'en',
  voteCount: 11124,
  name: 'Loki',
  originalName: 'Loki',
);

const tvSeries = TvSeries(
  posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
  popularity: 227.486,
  id: 84958,
  backdropPath: '/q3jHCb4dMfYF6ojikKuHd6LscxC.jpg',
  voteAverage: 8.18,
  overview:
      'After stealing the Tesseract during the events of “Avengers: Endgame,” an alternate version of Loki is brought to the mysterious Time Variance Authority, a bureaucratic organization that exists outside of time and space and monitors the timeline. They give Loki a choice: face being erased from existence due to being a “time variant” or help fix the timeline and stop a greater threat.',
  firstAirDate: '2021-06-09',
  originCountry: ['US'],
  genreIds: [18, 10765],
  originalLanguage: 'en',
  voteCount: 11124,
  name: 'Loki',
  originalName: 'Loki',
);

 const tvSeriesResponse = TvSeriesDetailResponse(
  backdropPath: 'backdropPath',
  firstAirDate: '2023-12-12',
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: 'https://google.com',
  id: 1,
  inProduction: false,
  languages: ['en'],
  lastAirDate: '2024-01-01',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 3,
  originCountry: ['US'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 242.0,
  posterPath: 'posterPath',
  seasons: [
    SeasonModel(
      airDate: '2023-12-12',
      episodeCount: 12,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 3,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 9.4,
  voteCount: 1000,
);

 const tvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  firstAirDate: '2023-12-12',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  lastAirDate: '2024-01-01',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 3,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [
    Season(
      airDate: '2023-12-12',
      episodeCount: 12,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 3,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 9.4,
  voteCount: 1000,
);
