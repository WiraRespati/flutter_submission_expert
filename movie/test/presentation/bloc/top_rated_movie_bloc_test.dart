
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  final tMoviesList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMoviesList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(tMoviesList),
    ],
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesEmpty(),
    ],
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Error] when get top rated movies is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      TopRatedMoviesLoading(),
      const TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );
}
