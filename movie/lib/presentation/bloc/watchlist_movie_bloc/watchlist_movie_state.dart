part of 'watchlist_movie_bloc.dart';

class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMovieState {}

class WatchlistMoviesLoading extends WatchlistMovieState {}

class WatchlistMoviesHasData extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMoviesError extends WatchlistMovieState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
