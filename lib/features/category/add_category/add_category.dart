import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/features/auths/widgets/form_text_field.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';
import 'package:todo_firebase/features/category/category_homepage/home_page.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
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
        title: Text("Add category"),
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
                hintText: "Enter category name",
                labelText: "Category",
                textEditingController: textEditingController,
                validatorFunction: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter category name";
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
                    child: Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, _) {
                        return CustomAuthButton(
                          isLoading: categoryProvider.isAdding,
                          onPressedFunction: () async {
                            if (formKey.currentState!.validate()) {
                              await categoryProvider.addCategory(
                                categoryName: textEditingController.text,
                                userId: FirebaseAuth.instance.currentUser!.uid,
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
