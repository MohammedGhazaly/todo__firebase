import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';
import 'package:todo_firebase/features/notes/notes_provider/notes_provider.dart';

class NoInternetWidgetNotes extends StatelessWidget {
  final String categoryId;
  const NoInternetWidgetNotes({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No internet connection",
            ),
            TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white),
                onPressed: () async {
                  if (!context.mounted) return;

                  Provider.of<NotesProvider>(context, listen: false)
                      .getNotes(context, categoryId);
                },
                child: Text("Try again"))
          ],
        ),
      ),
    );
  }
}
