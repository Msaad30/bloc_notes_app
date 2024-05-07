import 'package:bloc_notes_app/database/db_helper.dart';
import 'package:bloc_notes_app/utils/ui_helper.dart';

class NotesModel{
  int? id;
  String title;
  String desc;

  NotesModel({this.id, required this.title, required this.desc});

  Map<String, dynamic> toMap() {
    return {
      DbHelper.id : id,
      DbHelper.title : title,
      DbHelper.desc : desc
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic>mapData) {
    return NotesModel(
        id: mapData[DbHelper.id],
        title: mapData[DbHelper.title],
        desc: mapData[DbHelper.desc]
    );
  }

}