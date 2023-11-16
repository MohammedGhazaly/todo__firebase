import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/category/edit_category/edit_category.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';
import 'package:todo_firebase/features/category/category_homepage/widgets/category_card.dart';
import 'package:todo_firebase/features/notes/notes_homepage/notes_page.dart';
import 'package:todo_firebase/features/category/no_internet_widget_categories.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        {
          if (categoryProvider.isConnecting == false) {
            return NoInternetWidgetCategories();
          } else {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: categoryProvider.isFetching == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.orange,
                    ))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NotesPage(
                                  categoryName: categoryProvider
                                      .categories[index]["name"] as String,
                                  categoryId:
                                      categoryProvider.categories[index].id);
                            }));
                          },
                          onLongPress: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              btnCancelText: "delete",
                              btnOkText: "update",
                              btnOkOnPress: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditCategory(
                                    categoryId:
                                        categoryProvider.categories[index].id,
                                    categoryName: categoryProvider
                                        .categories[index]["name"] as String,
                                  );
                                }));
                              },
                              btnCancelOnPress: () async {
                                await categoryProvider.removeCategory(context,
                                    categoryProvider.categories[index].id);
                              },
                              body: const Center(
                                child: Text(
                                  "You can update or delete the category.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ).show();
                          },
                          child: CategoryCard(
                            categoryName: categoryProvider.categories[index]
                                ["name"] as String,
                          ),
                        );
                      },
                    ),
            );
          }
        }
      },
    );
  }
}
