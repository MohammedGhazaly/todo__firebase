import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/features/category/category_homepage/home_page.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
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

                  Provider.of<CategoryProvider>(context).getCategories(context);
                },
                child: Text("Try again"))
          ],
        ),
      ),
    );
  }
}
