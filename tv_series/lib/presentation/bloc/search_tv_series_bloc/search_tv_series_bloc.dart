import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series/domain/usecases/seach_tv_series.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  final SearchTvSeries _searchTvSeries;
  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvSeriesLoading());
        final result = await _searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(SearchTvSeriesError(failure.message));
          },
          (data) {
            emit(SearchTvSeriesHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
