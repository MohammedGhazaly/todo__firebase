import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/features/auths/widgets/form_text_field.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';
import 'package:todo_firebase/features/category/category_homepage/home_page.dart';

class EditCategory extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  const EditCategory(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
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
    textEditingController = TextEditingController(text: widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Category"),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context,
            //     MaterialPageRoute(builder: (context) {
            //   return HomePage();
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
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CustomAuthButton(
                      isLoading: categoryProvider.isUpdating,
                      onPressedFunction: () async {
                        if (formKey.currentState!.validate()) {
                          await categoryProvider.editCateogry(
                            newName: textEditingController.text,
                            categoryId: widget.categoryId,
                            context: context,
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
