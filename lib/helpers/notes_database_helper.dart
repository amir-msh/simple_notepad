import 'package:path/path.dart';
import 'package:simple_notepad/models/note_model.dart';
import 'package:sqflite/sqflite.dart' as sqf;

class NotesDatabaseHelper {
  static Future<sqf.Database> database() async {
    final path = await sqf.getDatabasesPath();
    // await sqf.deleteDatabase(
    //   join(path, 'notes.db'),
    // );
    return sqf.openDatabase(
      join(path, 'notes.db'),
      version: 1,
      onCreate: (db, _) async {
        db.execute('''
        CREATE TABLE ${NotesTable.tableName}(
          ${NotesTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${NotesTable.title} TEXT NOT NULL,
          ${NotesTable.content} TEXT NOT NULL,
          ${NotesTable.color} INT,
          ${NotesTable.dateTime} INT NOT NULL
        )
        ''');
      },
    );
  }

  static Future<List<NoteModel>> getNotes() async {
    final db = await NotesDatabaseHelper.database();
    final data = await db.query(
      NotesTable.tableName,
      orderBy: '${NotesTable.dateTime} DESC',
    );
    await db.close();
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }

  static Future addOrUpdateNote(NoteModel note) async {
    final db = await NotesDatabaseHelper.database();
    await db.insert(
      NotesTable.tableName,
      note.toJson(),
      conflictAlgorithm: sqf.ConflictAlgorithm.replace,
    );
    await db.close();
  }

  static Future deleteNote(int noteId) async {
    final db = await NotesDatabaseHelper.database();
    await db.delete(
      NotesTable.tableName,
      where: 'id=?',
      whereArgs: [noteId],
    );
    await db.close();
  }

  static Future<bool> noteExists(int noteId) async {
    final db = await NotesDatabaseHelper.database();
    final data = await db.query(
      NotesTable.tableName,
      where: 'id=?',
      whereArgs: [noteId],
    );
    await db.close();
    return data.isNotEmpty;
  }
}

class NotesTable {
  static const tableName = 'notes';
  static const id = 'id';
  static const title = 'title';
  static const content = 'content';
  static const color = 'color';
  static const dateTime = 'date_time';
}
