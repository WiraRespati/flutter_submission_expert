import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series/watchlist_tv_series_bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv_series/dummy_objects.dart';

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class FakeWatchlistTvSeriesEvent extends Fake
    implements WatchlistTvSeriesEvent {}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

void main() {
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistTvSeriesEvent());
    registerFallbackValue(FakeWatchlistTvSeriesState());
  });

  setUp(() {
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesBloc>.value(
      value: mockWatchlistTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(WatchlistTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesHasData([tvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(WatchlistTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(WatchlistTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesEmpty());

    final textErrorBarFinder = find.text('Watchlist is Empty');

    await tester.pumpWidget(makeTestableWidget(WatchlistTvSeriesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
