import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  const CategoryCard({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/folder.png",
              height: 90,
            ),
            Text(categoryName)
          ],
        ),
      ),
    );
  }
}
