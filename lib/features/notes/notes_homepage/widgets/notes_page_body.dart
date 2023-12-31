import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/notes/edit_notes/edit_note.dart';
import 'package:todo_firebase/features/notes/no_internet_widget_notes.dart';
import 'package:todo_firebase/features/notes/notes_homepage/widgets/notes_card.dart';
import 'package:todo_firebase/features/notes/notes_provider/notes_provider.dart';

class NotesPageBody extends StatefulWidget {
  final String categoryId;
  const NotesPageBody({super.key, required this.categoryId});

  @override
  State<NotesPageBody> createState() => _NotesPageBodyState();
}

class _NotesPageBodyState extends State<NotesPageBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotesProvider>(context, listen: false)
        .getNotes(context, widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    if (notesProvider.isConnecting == false) {
      return NoInternetWidgetNotes(categoryId: widget.categoryId);
    } else if (notesProvider.isFetching) {
      return Center(
          child: CircularProgressIndicator(
        color: Colors.orange,
      ));
    }
    return GridView.builder(
      itemCount: notesProvider.notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              btnCancelText: "delete",
              btnOkText: "update",
              btnOkOnPress: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditNote(
                    note: notesProvider.notes[index]["note"] as String,
                    noteId: notesProvider.notes[index].id,
                    categoryId: widget.categoryId,
                  );
                }));
              },
              btnCancelOnPress: () async {
                await notesProvider.removeNote(
                  context: context,
                  categoryId: widget.categoryId,
                  noteId: notesProvider.notes[index].id,
                );
              },
              body: const Center(
                child: Text(
                  "You can update or delete the note.",
                  textAlign: TextAlign.center,
                ),
              ),
            ).show();
          },
          child: NotesCard(
            note: notesProvider.notes[index]["note"] as String,
          ),
        );
      },
    );
  }
}
