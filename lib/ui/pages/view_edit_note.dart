import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notepad/models/note_model.dart';
import 'package:simple_notepad/provider/notes_provider.dart';
import 'package:simple_notepad/utils/note_actions.dart';

class ViewEditNotePage extends StatefulWidget {
  static const String name = '/add_note';
  final NoteModel data;
  const ViewEditNotePage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewEditNotePage> createState() => _ViewEditNotePageState();
}

class _ViewEditNotePageState extends State<ViewEditNotePage> {
  final _formState = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  final _editEnabledNotifier = ValueNotifier<bool>(false);

  Future onNoteSubmitted() async {
    if (_editEnabledNotifier.value) {
      if (_formState.currentState?.validate() ?? false) {
        _formState.currentState!.save();
        context.read<NotesProvider>().addOrUpdateNote(
              widget.data.copyWith(
                title: _title,
                content: _content,
                dateTime: DateTime.now(),
              ),
            );
        _editEnabledNotifier.value = !_editEnabledNotifier.value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Note'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<NotesProvider>().removeNote(widget.data.id!);
              Navigator.of(context).pop(NoteAction.delete);
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 75),
        child: ValueListenableBuilder<bool>(
          valueListenable: _editEnabledNotifier,
          builder: (context, enabled, child) => Form(
            key: _formState,
            child: Column(
              children: [
                TextFormField(
                  enabled: enabled,
                  focusNode: _titleFocusNode,
                  maxLines: 1,
                  initialValue: widget.data.title,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  enableIMEPersonalizedLearning: true,
                  enableSuggestions: true,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) => _title = newValue ?? '',
                  onFieldSubmitted: (value) => _contentFocusNode.requestFocus(),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  enabled: enabled,
                  focusNode: _contentFocusNode,
                  initialValue: widget.data.content,
                  decoration: const InputDecoration(
                    label: Text('Content'),
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
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _editEnabledNotifier,
        builder: (context, value, child) => FloatingActionButton.extended(
          // key: ValueKey(value),
          onPressed: onNoteSubmitted,
          label: AnimatedCrossFade(
            duration: const Duration(milliseconds: 175),
            firstCurve: Curves.easeInOut,
            secondCurve: Curves.easeInOut,
            crossFadeState:
                value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const Text(
              'Edit',
              key: Key('edit'),
            ),
            secondChild: const Text(
              'Submit',
              key: Key('submit'),
            ),
          ),
        ),
      ),
    );
  }
}
