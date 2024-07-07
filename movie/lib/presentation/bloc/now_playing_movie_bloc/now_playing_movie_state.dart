part of 'now_playing_movie_bloc.dart';

sealed class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMovieState {}

class NowPlayingMoviesLoading extends NowPlayingMovieState {}

class NowPlayingMoviesHasData extends NowPlayingMovieState {
  final List<Movie> result;

  const NowPlayingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class NowPlayingMoviesError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}