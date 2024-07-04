part of 'detail_movie_bloc.dart';

class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  const FetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}
