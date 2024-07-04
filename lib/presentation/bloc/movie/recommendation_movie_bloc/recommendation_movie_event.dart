part of 'recommendation_movie_bloc.dart';

class RecommendationMovieEvent extends Equatable {
  const RecommendationMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationMovie extends RecommendationMovieEvent {
  final int id;

  const FetchRecommendationMovie(this.id);
  @override
  List<Object> get props => [id];
}
