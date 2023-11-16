import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/features/auths/widgets/form_text_field.dart';
import 'package:todo_firebase/features/notes/notes_provider/notes_provider.dart';

class EditNote extends StatefulWidget {
  final String note;
  final String categoryId;
  final String noteId;
  const EditNote({
    super.key,
    required this.note,
    required this.categoryId,
    required this.noteId,
  });

  @override
  State<EditNote> createState() => EditNoteState();
}

class EditNoteState extends State<EditNote> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController textEditingController;

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              CustomFormTextField(
                hintText: "Enter new note",
                labelText: "Note",
                textEditingController: textEditingController,
                validatorFunction: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter note name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomAuthButton(
                      isLoading: notesProvider.isUpdating,
                      onPressedFunction: () async {
                        if (formKey.currentState!.validate()) {
                          await notesProvider.editNote(
                            newNote: textEditingController.text,
                            categoryId: widget.categoryId,
                            context: context,
                            noteId: widget.noteId,
                          );
                        }
                      },
                      text: "Update",
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
