import 'dart:developer';
import 'package:bloc_notes_app/bloc/notes_bloc.dart';
import 'package:bloc_notes_app/bloc/notes_events.dart';
import 'package:bloc_notes_app/bloc/notes_states.dart';
import 'package:bloc_notes_app/model/note_model.dart';
import 'package:bloc_notes_app/screens/notes_list.dart';
import 'package:bloc_notes_app/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesAdd extends StatefulWidget {
  const NotesAdd({super.key});

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          UiHelper.customTextFeild(
              controller: titleController,
              hintText: "Title",
              icon: Icons.title),
          UiHelper.customTextFeild(
              controller: descController,
              hintText: "Description",
              icon: Icons.description),
          ElevatedButton(
            onPressed: () {
              addNote(
                  title: titleController.text.toString(),
                  desc: descController.text.toString()
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: Text(
              "Add Note",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteList()));
        },
        child: Icon(Icons.list),
      ),
    );
  }

  void addNote({required String title, required String desc}){
    if(title == null || desc == null){
      log("please enter data");
    } else {
      context.read<NotesBloc>().add(
          AddEvent(
              notesModel: NotesModel(
                  title: title,
                  desc: desc
              )
          )
      );
      log("data has added");
    }
  }
}
