import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_note/models/note.dart';
import 'package:flutter_note/repositories/note_repository.dart';
import 'package:flutter_note/repositories/user_repository.dart';

class HomeScreenBloc {
  final UserRepository _userRepository;
  final NoteRepository _noteRepository;

  final List<Note> _notes = List();
  final List<Note> _onlineNotes = List();
  FirebaseUser user;
  final _noteStreamController = StreamController<List<Note>>();
  Stream<List<Note>> get noteStream => _noteStreamController.stream;
  Stream<bool> get isSignedInStream => _userRepository.isSignedInStream;
  HomeScreenBloc(this._userRepository, this._noteRepository) {
    _init();
  }

  _init() async {
    _userRepository.userStream.listen((u) {
      this.user = u;
      if (u != null) {
        _noteRepository.getNotesStreamForUser(u.uid).listen((d) {
          _onlineNotes.clear();
          _onlineNotes.addAll(d);
          _noteStreamController.add(d);
        });
      } else {
        _noteStreamController.add(_notes);
      }
    });
  }

  void addNote(String title, String body) async {
    if (user != null) {
      await _noteRepository.addNote(user.uid, title, body);
    } else {
      _notes.add(Note(_notes.length.toString(), title, body));
      _noteStreamController.add(_notes);
    }
  }

  void deleteNote(int id) {
    if (user != null) {
      _noteRepository.deleteNote(user.uid, _onlineNotes[id].id);
    } else {
      _notes.removeAt(id);
      _noteStreamController.add(_notes);
    }
  }

  void signOut() {
    _userRepository.signOut();
  }

  void signIn() {
    _userRepository.signInWithGoogle();
  }

  void dispose() {
    _noteStreamController.close();
  }
}
