part of 'pupular_movie_bloc.dart';

class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMoviesEmpty extends PopularMovieState {}

class PopularMoviesLoading extends PopularMovieState {}

class PopularMoviesHasData extends PopularMovieState {
  final List<Movie> result;

  const PopularMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class PopularMoviesError extends PopularMovieState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
