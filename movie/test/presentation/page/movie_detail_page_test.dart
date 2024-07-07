

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/detail_movie_bloc/detail_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_status_movie_bloc/watchlist_status_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class FakeDetailMovieEvent extends Fake implements DetailMovieEvent {}

class FakeDetailMovieState extends Fake implements DetailMovieState {}

class MockRecommendationMovieBloc
    extends MockBloc<RecommendationMovieEvent, RecommendationMovieState>
    implements RecommendationMovieBloc {}

class FakeRecommendationMovieEvent extends Fake
    implements RecommendationMovieEvent {}

class FakeRecommendationMovieState extends Fake
    implements RecommendationMovieState {}

class MockWatchlistStatusMovieBloc
    extends MockBloc<WatchlistStatusMovieEvent, WatchlistStatusMovieState>
    implements WatchlistStatusMovieBloc {}

class FakeWatchlistStatusMovieEvent extends Fake
    implements WatchlistStatusMovieEvent {}

class FakeWatchlistStatusMovieState extends Fake
    implements WatchlistStatusMovieState {}

void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockRecommendationMovieBloc mockRecommendationMovieBloc;
  late MockWatchlistStatusMovieBloc mockWatchlistStatusMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeDetailMovieEvent());
    registerFallbackValue(FakeDetailMovieState());
    registerFallbackValue(FakeRecommendationMovieEvent());
    registerFallbackValue(FakeRecommendationMovieState());
    registerFallbackValue(FakeWatchlistStatusMovieEvent());
    registerFallbackValue(FakeWatchlistStatusMovieState());
  });

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
    mockRecommendationMovieBloc = MockRecommendationMovieBloc();
    mockWatchlistStatusMovieBloc = MockWatchlistStatusMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>.value(value: mockDetailMovieBloc),
        BlocProvider<RecommendationMovieBloc>.value(
          value: mockRecommendationMovieBloc,
        ),
        BlocProvider<WatchlistStatusMovieBloc>.value(
          value: mockWatchlistStatusMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationMovieHasData([testMovie]));
    when(() => mockWatchlistStatusMovieBloc.state).thenReturn(
        const WatchlistStatusMovieState(
            isAddedToWatchlist: false, message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationMovieHasData([testMovie]));
    when(() => mockWatchlistStatusMovieBloc.state).thenReturn(
        const WatchlistStatusMovieState(isAddedToWatchlist: true, message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationMovieHasData([testMovie]));

    whenListen(
      mockWatchlistStatusMovieBloc,
      Stream.fromIterable([
        const WatchlistStatusMovieState(
          isAddedToWatchlist: true,
          message: 'Added to Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusMovieState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final watchlistButtonIconCheck = find.byIcon(Icons.check);
    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Added to Watchlist');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(snackbar, findsNothing);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(watchlistButtonIconCheck, findsOneWidget);
    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationMovieHasData([testMovie]));

    whenListen(
      mockWatchlistStatusMovieBloc,
      Stream.fromIterable([
        const WatchlistStatusMovieState(
          isAddedToWatchlist: false,
          message: 'Removed from Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusMovieState(
        isAddedToWatchlist: true,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final watchlistButtonIconCheck = find.byIcon(Icons.check);
    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Removed from Watchlist');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(watchlistButtonIconCheck, findsOneWidget);
    expect(snackbar, findsNothing);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationMovieHasData([testMovie]));

    whenListen(
      mockWatchlistStatusMovieBloc,
      Stream.fromIterable([
        const WatchlistStatusMovieState(
          isAddedToWatchlist: false,
          message: 'Failed Add to Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusMovieState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final alertDialog = find.byType(AlertDialog);
    final textMessage = find.text('Failed Add to Watchlist');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(alertDialog, findsNothing);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(alertDialog, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets('movie should display message error when no internet network',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieError('Failed to connect to the network'));

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets(
    'Recommendations movie should display text when data is empty',
    (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(const DetailMovieHasData(testMovieDetail));
      when(() => mockRecommendationMovieBloc.state)
          .thenReturn(RecommendationMovieEmpty());
      when(() => mockWatchlistStatusMovieBloc.state).thenReturn(
        const WatchlistStatusMovieState(
          isAddedToWatchlist: false,
          message: '',
        ),
      );

      final textErrorBarFinder = find.text('No Recommendations');

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

      expect(textErrorBarFinder, findsOneWidget);
    },
  );

  testWidgets('Recommendations movie should display message error when error',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(const DetailMovieHasData(testMovieDetail));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(const RecommendationMovieError('Error'));
    when(() => mockWatchlistStatusMovieBloc.state).thenReturn(
      const WatchlistStatusMovieState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final textErrorBarFinder = find.text('Error');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: tId)));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
