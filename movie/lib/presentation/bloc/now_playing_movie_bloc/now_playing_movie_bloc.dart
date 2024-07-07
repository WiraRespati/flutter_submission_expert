import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';


part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold((failure) => emit(NowPlayingMoviesError(failure.message)),
              (data) {
            if (data.isEmpty) {
              emit(NowPlayingMoviesEmpty());
            } else {
              emit(NowPlayingMoviesHasData(data));
            }
          });
    });
  }
}