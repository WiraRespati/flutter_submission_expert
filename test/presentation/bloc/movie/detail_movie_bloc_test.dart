import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail_movie_bloc/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../../dummy_data/movie/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetDetailMovie;

  setUp(() {
    mockGetDetailMovie = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetDetailMovie);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(detailMovieBloc.state, DetailMovieEmpty());
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetDetailMovie.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailMovie(tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieHasData(testMovieDetail),
    ],
    verify: (bloc) => verify(mockGetDetailMovie.execute(tId)),
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, Error] when get detail tv series is unsuccessful',
    build: () {
      when(mockGetDetailMovie.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailMovie(tId)),
    expect: () => [
      DetailMovieLoading(),
      const DetailMovieError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetDetailMovie.execute(tId)),
  );
}
