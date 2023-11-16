import 'package:flutter/material.dart';
import 'package:todo_firebase/features/notes/add_notes/add_notes.dart';
import 'package:todo_firebase/features/notes/notes_homepage/widgets/notes_page_body.dart';

class NotesPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  const NotesPage(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNotes(
              categoryId: categoryId,
            );
          }));
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      body: NotesPageBody(categoryId: categoryId),
    );
  }
}
