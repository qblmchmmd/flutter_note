import 'package:flutter_note/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepository {
  Stream<List<Note>> getNotesStreamForUser(String uid) {
    return Firestore.instance
        .collection("users")
        .document(uid)
        .collection("notes")
        .snapshots()
        .map<List<Note>>((snapshot) {
      return snapshot.documents.map((d) {
        return Note(d.documentID, d.data['title'], d.data['body']);
      }).toList();
    });
  }

  Future<void> addNote(String uid, String title, String body,
      {String id}) async {
    await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("notes")
        .document(id)
        .setData({
      'title': title,
      'body': body,
    });
  }

  Future<void> deleteNote(String uid, String id) async {
    await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("notes")
        .document(id)
        .delete();
  }
}
