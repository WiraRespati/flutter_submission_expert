part of 'watchlist_status_movie_bloc.dart';

class WatchlistStatusMovieState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const WatchlistStatusMovieState({
    required this.isAddedToWatchlist,
    required this.message,
  });

  @override
  List<Object> get props => [isAddedToWatchlist, message];
}
