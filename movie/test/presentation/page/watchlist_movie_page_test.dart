import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class FakeWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState {}

void main() {
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
  });

  setUp(() {
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: mockWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMoviesHasData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMoviesEmpty());

    final textErrorBarFinder = find.text('Watchlist is Empty');

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
