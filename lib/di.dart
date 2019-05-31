import 'package:dartin/dartin.dart';
import 'package:flutter_note/blocs/homescreen_bloc.dart';
import 'package:flutter_note/repositories/note_repository.dart';
import 'package:flutter_note/repositories/user_repository.dart';

final blocModule = Module([
  factory<HomeScreenBloc>(({params}) =>
      HomeScreenBloc(get<UserRepository>(), get<NoteRepository>())),
]);

final repoModule = Module([
  single<UserRepository>(UserRepository()),
  single<NoteRepository>(NoteRepository()),
]);

final appModule = [repoModule, blocModule];
