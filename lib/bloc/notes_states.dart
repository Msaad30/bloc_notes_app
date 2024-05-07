import 'package:bloc_notes_app/model/note_model.dart';

abstract class NoteState{}
class InitialState extends NoteState{}
class LoadingState extends NoteState{}
class LoadedState extends NoteState{
  List<NotesModel> array;
  LoadedState({required this.array});
}
class ErrorState extends NoteState{
  String errorMsg;
  ErrorState({required this.errorMsg});
}