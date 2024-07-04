import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedMoviesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(TopRatedMoviesEmpty());
          } else {
            emit(TopRatedMoviesHasData(data));
          }
        },
      );
    });
  }
}
