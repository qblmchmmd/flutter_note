// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_note/screens/detailscreen.dart';
import 'package:flutter_note/screens/homescreen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Click add FAB opens NoteDetail', (WidgetTester tester) async {
    // Given
    MockNavigatorObserver mNavObs = MockNavigatorObserver();
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
      navigatorObservers: [mNavObs],
    ));

    // When
    await tester.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
    await tester.pumpAndSettle();

    // Then
    verify(mNavObs.didPush(any, any)).called(2); // First initial HomeScreen push second DetailScreen push
    expect(find.byType(DetailScreen), findsOneWidget);
  });

  testWidgets('Return success from NoteDetail, add listitem', (WidgetTester t) async {
    // Given
    MockNavigatorObserver mNavObs = MockNavigatorObserver();
    await t.pumpWidget(MaterialApp(
      home: HomeScreen(),
      navigatorObservers: [mNavObs],
    ));
    expect(find.text("TitleTest"), findsNothing);
    expect(find.text("BodyTest"), findsNothing);
    expect(find.text("TitleTest2"), findsNothing);
    expect(find.text("BodyTest2"), findsNothing);

    // When
    await t.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).first, "TitleTest");
    await t.enterText(find.byType(TextField).last, "BodyTest");
    await t.tap(find.widgetWithIcon(FloatingActionButton, Icons.check));
    await t.pumpAndSettle();

    // Then
    expect(find.text("TitleTest"), findsOneWidget);
    expect(find.text("BodyTest"), findsOneWidget);
    expect(find.text("TitleTest2"), findsNothing);
    expect(find.text("BodyTest2"), findsNothing);

    // When
    await t.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField).first, "TitleTest2");
    await t.enterText(find.byType(TextField).last, "BodyTest2");
    await t.tap(find.widgetWithIcon(FloatingActionButton, Icons.check));
    await t.pumpAndSettle();

    // Then
    expect(find.text("TitleTest"), findsOneWidget);
    expect(find.text("BodyTest"), findsOneWidget);
    expect(find.text("TitleTest2"), findsOneWidget);
    expect(find.text("BodyTest2"), findsOneWidget);
  });
}
