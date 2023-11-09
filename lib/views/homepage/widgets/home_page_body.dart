import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/views/homepage/category_provider/category_provider.dart';
import 'package:todo_firebase/views/homepage/widgets/category_card.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
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
