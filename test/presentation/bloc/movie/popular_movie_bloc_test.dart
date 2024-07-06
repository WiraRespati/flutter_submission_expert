
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc/pupular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  final tMoviesList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(popularMoviesBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMoviesList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(tMoviesList),
    ],
    verify: (bloc) => verify(mockGetPopularMovies.execute()),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesEmpty(),
    ],
    verify: (bloc) => verify(mockGetPopularMovies.execute()),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Error] when get popular movies is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      const PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetPopularMovies.execute()),
  );
}
