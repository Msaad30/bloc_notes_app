import 'package:bloc_notes_app/model/note_model.dart';

abstract class NoteEvents{}
class AddEvent extends NoteEvents{
  NotesModel notesModel;
  AddEvent({required this.notesModel});
}
class FetchEvent extends NoteEvents{}
class DeleteEvent extends NoteEvents{
  int? id;
  DeleteEvent({required this.id});
}
class UpdateEvent extends NoteEvents{
  NotesModel notesModel;
  UpdateEvent({required this.notesModel});
}
