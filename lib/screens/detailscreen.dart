import 'package:flutter/material.dart';
import 'package:flutter_note/keys/keys.dart';

typedef DetailScreenCallback = Function(String title, String body);

class DetailScreen extends StatefulWidget {
  final DetailScreenCallback _cb;

  DetailScreen(this._cb, {Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController bodyCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            TextField(
              key: titleFieldKey,
              controller: titleCon,
              enabled: true,
              style: TextStyle(color: Colors.blue),
              decoration: InputDecoration(
                hintText: "Note Title",
                disabledBorder: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                key: bodyFieldKey,
                controller: bodyCon,
                decoration: InputDecoration(hintText: "Note Body"),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
                key: saveNoteKey,
                child: Icon(Icons.check),
                onPressed: () {
                  final String title = titleCon.text;
                  final String body = bodyCon.text;

                  if (title.isEmpty && body.isEmpty) {
                    Scaffold.of(ctx).showSnackBar(SnackBar(
                      content: Text("At least one field should be filled"),
                    ));
                  } else {
                    widget._cb(title, body);
                    Navigator.of(context).pop();
                  }
                },
              ),
        ));
  }
}
