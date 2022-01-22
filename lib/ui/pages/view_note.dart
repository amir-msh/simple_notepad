import 'package:flutter/material.dart';
import 'package:simple_notepad/models/note_model.dart';

class ViewNotePage extends StatelessWidget {
  static const String name = '/view_note';
  final NoteModel data;

  const ViewNotePage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
