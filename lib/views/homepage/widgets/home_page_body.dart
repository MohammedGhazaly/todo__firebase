import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/views/add_category/add_category.dart';
import 'package:todo_firebase/views/homepage/category_provider/category_provider.dart';
import 'package:todo_firebase/views/homepage/widgets/category_card.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: true);
    print("Hi");
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: categoryProvider.isFetching == true
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              color: Colors.orange,
            ))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoryName: categoryProvider.categories[index],
                );
              },
            ),
    );
  }
}
