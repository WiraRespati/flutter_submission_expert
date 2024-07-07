part of 'top_rated_movie_bloc.dart';

class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends TopRatedMovieState {}

class TopRatedMoviesLoading extends TopRatedMovieState {}

class TopRatedMoviesHasData extends TopRatedMovieState {
  final List<Movie> result;

  const TopRatedMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedMoviesError extends TopRatedMovieState {
  final String message;

  const TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
