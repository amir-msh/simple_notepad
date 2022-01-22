import 'package:flutter/material.dart';
import 'package:simple_notepad/helpers/notes_database_helper.dart';
import 'package:simple_notepad/models/note_model.dart';

enum NotesState {
  initial,
  loading,
  loadSuccess,
  loadFailed,
}

class NotesProvider extends ChangeNotifier {
  var _notesState = NotesState.initial;
  List<NoteModel> _notes = const [];

  List<NoteModel> get notes => _notes;
  NotesState get notesState => _notesState;

  Future loadNotes() async {
    _notesState = NotesState.loading;
    await Future.delayed(const Duration(microseconds: 50));
    notifyListeners();
    try {
      _notes = await NotesDatabaseHelper.getNotes();
      _notesState = NotesState.loadSuccess;
    } catch (e) {
      print(e);
      _notesState = NotesState.loadFailed;
    }
    await Future.delayed(const Duration(microseconds: 50));
    notifyListeners();
  }

  Future addOrUpdateNote(NoteModel note) async {
    _notesState = NotesState.loading;
    await Future.delayed(const Duration(microseconds: 50));
    try {
      await NotesDatabaseHelper.addOrUpdateNote(note);
      _notes = await NotesDatabaseHelper.getNotes();
      _notesState = NotesState.loadSuccess;
    } catch (e) {
      _notesState = NotesState.loadFailed;
    }
    await Future.delayed(const Duration(microseconds: 50));
    notifyListeners();
  }

  Future removeNote(int noteId) async {
    _notesState = NotesState.loading;
    await Future.delayed(const Duration(microseconds: 50));
    try {
      await NotesDatabaseHelper.deleteNote(noteId);
      _notes = await NotesDatabaseHelper.getNotes();
      // _notes.removeWhere((i) => i.id == noteId);
      _notesState = NotesState.loadSuccess;
    } catch (e) {
      _notesState = NotesState.loadFailed;
    }
    await Future.delayed(const Duration(microseconds: 50));
    notifyListeners();
  }
}
