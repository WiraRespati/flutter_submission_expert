
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, HasData] when data is gotten succesfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(tMovieList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesEmpty(),
    ],
    verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
  );
}
