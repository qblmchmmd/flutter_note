import 'package:flutter/material.dart';

const addNoteKey = Key("AddNote");
const saveNoteKey = Key("SaveNote");
const titleFieldKey = Key("TitleField");
const bodyFieldKey = Key("BodyField");
Key noteTitleKey(int idx) => Key("NoteTitle$idx");
Key noteBodyKey(int idx) => Key("NoteBody$idx");