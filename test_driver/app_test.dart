import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('FlutterNotApp', () {
    final fabAddFinder = find.byValueKey("AddNote");
    final fabCheckFinder = find.byValueKey("SaveNote");
    final titleFieldFinder = find.byValueKey("TitleField");
    final bodyFieldFinder = find.byValueKey("BodyField");

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(()async {
      driver?.close();
    });

    _createNote(String title, String body) async {
      await(driver.tap(fabAddFinder));

      await(driver.tap(titleFieldFinder));
      await(driver.enterText(title));

      await(driver.tap(bodyFieldFinder));
      await(driver.enterText(body));

      await(driver.tap(fabCheckFinder));
    }

    test('Create Multiple Note', () async {
      await _createNote("title1", "body1");
      expect(await driver.getText(find.byValueKey("NoteTitle0")) , "title1");
      expect(await driver.getText(find.byValueKey("NoteBody0")) , "body1");
      await _createNote("title2", "body2");
      expect(await driver.getText(find.byValueKey("NoteTitle0")) , "title1");
      expect(await driver.getText(find.byValueKey("NoteBody0")) , "body1");
      expect(await driver.getText(find.byValueKey("NoteTitle1")) , "title2");
      expect(await driver.getText(find.byValueKey("NoteBody1")) , "body2");
    });
  });
}