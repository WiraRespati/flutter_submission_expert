// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';


part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getDetailMovie;

  DetailMovieBloc(
    this.getDetailMovie,
  ) : super(DetailMovieEmpty()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(DetailMovieLoading());

      final id = event.id;
      final result = await getDetailMovie.execute(id);

      result.fold(
        (failure) => emit(DetailMovieError(failure.message)),
        (data) => emit(DetailMovieHasData(data)),
      );
    });
  }
}
