import 'package:flutter/material.dart';
import 'package:simple_notepad/models/note_model.dart';
import 'package:simple_notepad/ui/pages/view_edit_note.dart';

class NoteItem extends StatelessWidget {
  final NoteModel data;
  const NoteItem({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 90,
        maxWidth: double.infinity,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          // fit: StackFit.expand,
          children: [
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueGrey[800]!,
                      Colors.blueGrey[800]!,
                    ],
                  ),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueGrey[50]!,
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.05),
                    ],
                  ).createShader(bounds),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.title,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Flexible(
                        child: Text(
                          data.content,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewEditNotePage(
                          data: data,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
