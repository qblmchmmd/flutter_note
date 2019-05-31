import 'package:flutter/material.dart';
import 'package:flutter_note/blocs/homescreen_bloc.dart';
import 'package:flutter_note/keys/keys.dart';
import 'package:flutter_note/models/note.dart';
import 'package:flutter_note/screens/detailscreen.dart';
import 'package:dartin/dartin.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenBloc bloc = inject<HomeScreenBloc>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Note"),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: widget.bloc.isSignedInStream,
            initialData: false,
            builder: (ctx, s) => s.data
                ? IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () => widget.bloc.signOut(),
                  )
                : IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () => widget.bloc.signIn(),
                  ),
          ),
        ],
      ),
      body: StreamBuilder<List<Note>>(
          stream: widget.bloc.noteStream,
          builder: (ctx, snapshot) => (snapshot.hasData)
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, idx) {
                    final Note note = snapshot.data[idx];
                    return ListTile(
                      title: Text(
                        note.title,
                        key: noteTitleKey(idx),
                      ),
                      subtitle: Text(
                        note.body,
                        key: noteBodyKey(idx),
                      ),
                      trailing: new PopupMenuButton<int>(
                        itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: 0,
                                child: Text("Delete"),
                              ),
                            ],
                        onSelected: (idx) {
                          widget.bloc.deleteNote(idx);
                        },
                      ),
                    );
                  },
                )
              : Container()),
      floatingActionButton: FloatingActionButton(
        key: addNoteKey,
        child: Icon(Icons.add),
        onPressed: () async {
          final destRoute = MaterialPageRoute(
              builder: (_) => DetailScreen((t, b) {
                    widget.bloc.addNote(t, b);
                  }));
          Navigator.push(context, destRoute);
        },
      ),
    );
  }
}
