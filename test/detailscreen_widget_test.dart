import 'package:flutter/material.dart';
import 'package:flutter_note/screens/detailscreen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'homescreen_widget_test.dart';
//class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  String titleRes;
  String bodyRes;

  final mockNav = MockNavigatorObserver();

  _buildSetup(WidgetTester t) async {
    await t.pumpWidget(MaterialApp(
      home: DetailScreen((t, b) {
        titleRes = t;
        bodyRes = b;
      }),
      navigatorObservers: [mockNav],
    ));
  }

  final Finder checkFab =
      find.widgetWithIcon(FloatingActionButton, Icons.check);

  testWidgets('have correct initial', (WidgetTester t) async {
    // Given
    await _buildSetup(t);

    // Then
    expect(find.byType(TextField), findsNWidgets(2));
    expect(checkFab, findsOneWidget);
  });

  testWidgets('empty fields show error', (WidgetTester t) async {
    // Given
    await _buildSetup(t);

    // When
    await t.tap(checkFab);
    await t.pump();

    // Then
    expect(find.text("At least one field should be filled"), findsOneWidget);
  });

  testWidgets('non empty fields show no error, callback result',
      (WidgetTester t) async {
    // Given
    await _buildSetup(t);
    final Route detailPushedRoute =
        verify(mockNav.didPush(captureAny, any)).captured.last;
    bool isPopped = false;
    detailPushedRoute.popped.whenComplete(() {
      isPopped = true;
    });

    // When
    await t.enterText(find.byType(TextField).first, "TitleTest");
    await t.enterText(find.byType(TextField).last, "BodyTest");
    await t.tap(checkFab);
    await t.pumpAndSettle();

    // Then
    expect(titleRes, "TitleTest");
    expect(bodyRes, "BodyTest");
    expect(isPopped, true);
  });
}
