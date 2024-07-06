import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc/pupular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';

class MockPopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class FakePopularMovieEvent extends Fake implements PopularMovieEvent {}

class FakePopularMovieState extends Fake implements PopularMovieState {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
  });

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMoviesHasData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(const PopularMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
