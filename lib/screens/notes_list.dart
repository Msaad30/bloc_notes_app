import 'dart:developer';

import 'package:bloc_notes_app/bloc/notes_bloc.dart';
import 'package:bloc_notes_app/bloc/notes_events.dart';
import 'package:bloc_notes_app/bloc/notes_states.dart';
import 'package:bloc_notes_app/model/note_model.dart';
import 'package:bloc_notes_app/screens/notes_add.dart';
import 'package:bloc_notes_app/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesBloc, NoteState>(
        builder: (BuildContext context, NoteState state) {
          if(state is LoadingState){
            return Center(
                child: CircularProgressIndicator()
            );
          } else if(state is LoadedState){
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var data = state.array[index];
                return ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(data.title.toString()),
                  subtitle: Text(data.desc.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UiHelper.iconBtn(() {
                        titleController.text = data.title.toString();
                        descController.text = data.desc.toString();
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    UiHelper.customTextFeild(
                                        controller: titleController,
                                        hintText: "title",
                                        icon: Icons.title),
                                    UiHelper.customTextFeild(
                                        controller: descController,
                                        hintText: "descrition",
                                        icon: Icons.description),
                                    ElevatedButton(
                                      onPressed: () {
                                        updateNote(
                                          NotesModel(
                                              id: data.id!.toInt(),
                                              title: titleController.text.toString(),
                                              desc: descController.text.toString()
                                          )
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey
                                      ),
                                      child: Text(
                                        "Update Note",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      }, icon: Icons.edit),
                      UiHelper.iconBtn(() {
                        context.read<NotesBloc>().add(
                            DeleteEvent(
                                id: state.array[index].id!.toInt()
                            )
                        );
                      },
                          icon: Icons.delete),
                    ],
                  ),
                );
              },
              itemCount: state.array.length,
            );
          }
          else if(state is ErrorState){
            return Center(
                child: Text(
                    state.errorMsg
                )
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.yellow,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NotesAdd()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void updateNote(NotesModel notesModel){
    context.read<NotesBloc>().add(
        UpdateEvent(notesModel: notesModel)
    );
    log("data has Updated");
  }

}
