part of 'watchlist_status_movie_bloc.dart';

class WatchlistStatusMovieEvent extends Equatable {
  const WatchlistStatusMovieEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistMovie extends WatchlistStatusMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlistMovie extends WatchlistStatusMovieEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlistMovie(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatusMovie extends WatchlistStatusMovieEvent {
  final int id;

  const LoadWatchlistStatusMovie(this.id);
  @override
  List<Object> get props => [id];
}
