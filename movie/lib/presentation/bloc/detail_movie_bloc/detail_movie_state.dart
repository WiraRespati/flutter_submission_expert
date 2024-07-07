part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieEmpty extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieError extends DetailMovieState {
  final String message;

  const DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail result;

  const DetailMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
