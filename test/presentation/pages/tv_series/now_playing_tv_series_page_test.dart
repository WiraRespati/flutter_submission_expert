import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series/now_playing_tv_series_bloc/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv_series/dummy_objects.dart';

class MockNowPlayingTvSeriesBloc
    extends MockBloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesBloc {}

class FakeNowPlayingTvSeriesEvent extends Fake
    implements NowPlayingTvSeriesEvent {}

class FakeNowPlayingTvSeriesState extends Fake
    implements NowPlayingTvSeriesState {}

void main() {
  late MockNowPlayingTvSeriesBloc mockNowPlayingTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingTvSeriesEvent());
    registerFallbackValue(FakeNowPlayingTvSeriesState());
  });

  setUp(() {
    mockNowPlayingTvSeriesBloc = MockNowPlayingTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesBloc>.value(
      value: mockNowPlayingTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state)
        .thenReturn(NowPlayingTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state)
        .thenReturn(const NowPlayingTvSeriesHasData([tvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state)
        .thenReturn(const NowPlayingTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
