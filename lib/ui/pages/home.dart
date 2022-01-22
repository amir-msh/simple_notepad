import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notepad/provider/notes_provider.dart';
import 'package:simple_notepad/ui/components/note_item.dart';
import 'package:simple_notepad/ui/pages/add_note.dart';
import 'package:simple_notepad/utils/note_actions.dart';

class HomePage extends StatefulWidget {
  static const String name = '/';
  static const double toolbarHeight = 63;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NotesProvider>().loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: HomePage.toolbarHeight,
        title: const Text('Notepad'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(27.5),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: HomePage.toolbarHeight + 25,
        ),
        child: Consumer<NotesProvider>(
          builder: (context, value, child) {
            if (value.notesState == NotesState.loadSuccess) {
              final notes = value.notes;
              debugPrint(notes.map((e) => e.toJson()).toString());
              if (notes.isNotEmpty) {
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 100),
                  itemCount: notes.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 9,
                    );
                  },
                  itemBuilder: (context, index) => Hero(
                    tag: notes[index],
                    child: NoteItem(
                      data: notes[index],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.note,
                        size: 39,
                      ),
                      SizedBox(height: 10),
                      Text("You don't have any note"),
                    ],
                  ),
                );
              }
            } else if (value.notesState == NotesState.loadFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red[900]!,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'An unknown error has occurred, please clear the data of the app and reopen it',
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final action = (await Navigator.of(context).push<NoteAction>(
            MaterialPageRoute(
              builder: (context) => const AddNotePage(),
            ),
          ));

          if (action != null && action != NoteAction.nothing) {
            String text = '';
            switch (action) {
              case NoteAction.add:
                text = 'Note added successfully';
                break;
              // case NoteAction.update:
              //   text = 'Note updated successfully';
              //   break;
              case NoteAction.delete:
                text = 'Note deleted successfully';
                break;
              default:
            }
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(text)),
                );
              },
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
