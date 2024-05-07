import 'package:bloc_notes_app/model/note_model.dart';
import 'package:bloc_notes_app/screens/notes_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  static final DbHelper dbHelper = DbHelper();
  static final String database = "note_db";
  static final String table = "notes";
  static final String id = "note_id";
  static final String title = "note_title";
  static final String desc = "note_desc";
  Database? _database;

  Future<Database> getDb() async{
    if(_database == null){
      return await initDb();
    } else {
      return _database!;
    }
  }

  Future<Database> initDb() async {
    var directory = await getApplicationDocumentsDirectory();
    directory.create(recursive: true);
    var path = directory.path + "notes.db";
    return openDatabase(path, version: 1, onCreate: (db, version){
      db.execute(
      """
        CREATE TABLE $table (
          $id INTEGER PRIMARY KEY AUTOINCREMENT,
          $title TEXT,
          $desc TEXT
        );
      """
      );
    });
  }

  Future<bool>insertData(NotesModel notesModel) async {
    var db = await getDb();
    var count = await db.insert(table, notesModel.toMap());
    return count > 0;
  }

  Future<List<NotesModel>>fetchData() async {
    var db = await getDb();
    List<Map<String, dynamic>> note = await db.query(table);
    List<NotesModel> notesList = [];
    for(Map<String, dynamic> notes in note){
      NotesModel noteModel = NotesModel.fromMap(notes);
      notesList.add(noteModel);
    }
    return notesList;
  }

  Future<bool>updateData(NotesModel noteModel) async {
    var db = await getDb();
    var count1 = await db.update(table, noteModel.toMap(), where: "$id=?", whereArgs: [noteModel.id]);
    return count1 > 0;
  }

  Future<bool>deleteData(int idNum) async {
    var db = await getDb();
    var count3 = await db.delete(table, where: "$id=?", whereArgs: [idNum.toInt()]);
    return count3 > 0;
  }
}