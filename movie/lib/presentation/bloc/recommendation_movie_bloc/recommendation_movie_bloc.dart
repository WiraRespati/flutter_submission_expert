// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendationMovieBloc(this.getMovieRecommendations)
      : super(RecommendationMovieEmpty()) {
    on<FetchRecommendationMovie>((event, emit) async {
      emit(RecommendationMovieLoading());

      final id = event.id;
      final result = await getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(RecommendationMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(RecommendationMovieEmpty());
          } else {
            emit(RecommendationMovieHasData(data));
          }
        },
      );
    });
  }
}
