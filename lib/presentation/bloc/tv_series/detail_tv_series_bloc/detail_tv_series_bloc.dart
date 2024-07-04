import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetTvSeriesDetail getDetailTvSeries;

  DetailTvSeriesBloc(
    this.getDetailTvSeries,
  ) : super(DetailTvSeriesEmpty()) {
    on<FetchDetailTvSeries>((event, emit) async {
      emit(DetailTvSeriesLoading());

      final id = event.id;
      final result = await getDetailTvSeries.execute(id);

      result.fold(
        (failure) => emit(DetailTvSeriesError(failure.message)),
        (data) => emit(DetailTvSeriesHasData(data)),
      );
    });
  }
}
