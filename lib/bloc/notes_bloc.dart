import 'package:bloc_notes_app/bloc/notes_events.dart';
import 'package:bloc_notes_app/bloc/notes_states.dart';
import 'package:bloc_notes_app/database/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NoteEvents, NoteState>{
  DbHelper dbHelper;
  NotesBloc({required this.dbHelper}) : super(InitialState()){

    on<AddEvent>((event, emit) async {
      emit(LoadingState());
      var check = await dbHelper.insertData(event.notesModel);
      if(check){
        var notes = await dbHelper.fetchData();
        emit(LoadedState(array: notes));
      } else {
        emit(ErrorState(errorMsg: "Error to AddNotes"));
      }
    });

    on<FetchEvent>((event, emit) async {
      emit(LoadingState());
      var array = await dbHelper.fetchData();
      if(array != []){
        emit(LoadedState(array: array));
      } else {
        emit(ErrorState(errorMsg: "Error to fetch"));
      }
    });

    on<UpdateEvent>((event, emit) async {
      emit(LoadingState());
      var check = await dbHelper.updateData(event.notesModel);
      if(check){
        var array = await dbHelper.fetchData();
        emit(LoadedState(array: array));
      } else {
        emit(ErrorState(errorMsg: "Error to update"));
      }
    });

    on<DeleteEvent>((event, emit) async {
      emit(LoadingState());
      await dbHelper.deleteData(event.id!);
      var array = await dbHelper.fetchData();
      emit(LoadedState(array: array));
    });
  }
}