import 'package:flutter/cupertino.dart';
import 'package:simple_notepad/helpers/notes_database_helper.dart';

class NoteModel {
  final int? id;
  final String title;
  final String content;
  final Color? color;
  final DateTime dateTime;

  const NoteModel({
    this.id,
    required this.title,
    required this.content,
    this.color,
    required this.dateTime,
  });

  factory NoteModel.fromJson(Map<String, Object?> json) {
    return NoteModel(
      id: json[NotesTable.id]! as int,
      title: (json[NotesTable.title] as String?) ?? '',
      content: json[NotesTable.content]! as String,
      color: json[NotesTable.color] == null
          ? null
          : Color(json[NotesTable.color] as int),
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(json[NotesTable.dateTime] as int),
    );
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    Color? color,
    DateTime? dateTime,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, Object?> toJson() {
    return {
      NotesTable.id: id,
      NotesTable.title: title,
      NotesTable.content: content,
      NotesTable.color: color?.value,
      NotesTable.dateTime: dateTime.millisecondsSinceEpoch,
    };
  }
}
