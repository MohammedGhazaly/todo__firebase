import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/views/add_category/add_category.dart';
import 'package:todo_firebase/views/homepage/category_provider/category_provider.dart';
import 'package:todo_firebase/views/homepage/home_page.dart';
import 'package:todo_firebase/views/homepage/widgets/category_card.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: true);
    if (categoryProvider.isConnecting == false) {
      return Center(
        child: RefreshIndicator(
          onRefresh: () async {},
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

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }));
                    },
                    child: Text("Try again"))
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: categoryProvider.isFetching == true
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              color: Colors.orange,
            ))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      title: "DELETEING CATEGORY!?",
                      btnOkOnPress: () async {
                        await categoryProvider.removeCategory(
                            context, categoryProvider.categories[index].id);
                      },
                      btnCancelOnPress: () {},
                      body: const Center(
                        child: Text(
                          "You are about to delete a category, are you sure?",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ).show();
                  },
                  child: CategoryCard(
                    categoryName:
                        categoryProvider.categories[index]["name"] as String,
                  ),
                );
              },
            ),
    );
  }
}
