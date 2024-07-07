part of 'recommendation_movie_bloc.dart';

class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationMovieEmpty extends RecommendationMovieState {}

class RecommendationMovieLoading extends RecommendationMovieState {}

class RecommendationMovieError extends RecommendationMovieState {
  final String message;

  const RecommendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMovieHasData extends RecommendationMovieState {
  final List<Movie> result;

  const RecommendationMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
