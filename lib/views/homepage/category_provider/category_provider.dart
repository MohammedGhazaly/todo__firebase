import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/views/homepage/home_page.dart';

class CategoryProvider extends ChangeNotifier {
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  bool isAdding = false;
  bool isFetching = true;
  List<String> categories = [];
  Future<void> addCategory(
      {required String categoryName, required BuildContext context}) async {
    isAdding = true;
    notifyListeners();
    try {
      DocumentReference response = await categoriesCollection.add({
        "name": categoryName,
      });

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$categoryName category added")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    } catch (e) {}
    isAdding = false;
    notifyListeners();
  }

  Future<void> getCategories() async {
    categories = [];
    try {
      QuerySnapshot categoriesSnapshot =
          await FirebaseFirestore.instance.collection("categories").get();

      categoriesSnapshot.docs.forEach((element) {
        categories.add(element["name"] as String);
      });
      print(categories);
    } on Exception catch (e) {
      // TODO
    }
    isFetching = false;
    notifyListeners();
  }
}
