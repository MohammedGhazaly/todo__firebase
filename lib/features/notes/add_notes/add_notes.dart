import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/features/auths/widgets/form_text_field.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';
import 'package:todo_firebase/features/notes/notes_provider/notes_provider.dart';

class AddNotes extends StatefulWidget {
  final String categoryId;
  const AddNotes({super.key, required this.categoryId});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) {
            //   return const HomePage();
            // }));
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
                hintText: "Enter note name",
                labelText: "Note",
                textEditingController: textEditingController,
                validatorFunction: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter name for note";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Consumer<NotesProvider>(
                      builder: (context, notesProvider, _) {
                        return CustomAuthButton(
                          isLoading: notesProvider.isAdding,
                          onPressedFunction: () async {
                            if (formKey.currentState!.validate()) {
                              await notesProvider.addNote(
                                categoryId: widget.categoryId,
                                note: textEditingController.text,
                                context: context,
                              );
                            }
                          },
                          text: "Add",
                        );
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
