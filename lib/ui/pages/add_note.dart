import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notepad/models/note_model.dart';
import 'package:simple_notepad/provider/notes_provider.dart';
import 'package:simple_notepad/utils/note_actions.dart';

class AddNotePage extends StatefulWidget {
  static const String name = '/add_note';
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formState = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();

  Future onNoteSubmitted() async {
    if (_formState.currentState?.validate() ?? false) {
      _formState.currentState!.save();
      context.read<NotesProvider>().addOrUpdateNote(
            NoteModel(
              title: _title,
              content: _content,
              dateTime: DateTime.now(),
            ),
          );

      Navigator.of(context).pop(NoteAction.add);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 75),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              TextFormField(
                focusNode: _titleFocusNode,
                autofocus: true,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,
                enableInteractiveSelection: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onSaved: (newValue) => _title = newValue ?? '',
                onFieldSubmitted: (value) => _contentFocusNode.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                focusNode: _contentFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Content',
                ),
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,
                enableInteractiveSelection: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                minLines: 10,
                maxLines: null,
                validator: (value) => (value?.isNotEmpty ?? false)
                    ? null
                    : "This field shouldn't be empty",
                onFieldSubmitted: (value) => onNoteSubmitted(),
                onSaved: (newValue) => _content = newValue ?? '',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onNoteSubmitted,
        label: const Text(
          'Submit',
        ),
      ),
    );
  }
}
