import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider extends ChangeNotifier {
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  bool isLoading = false;
  List<String> categories = [];
  Future<void> addCategory(
      {required String categoryName, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      DocumentReference response = await categoriesCollection.add({
        "name": categoryName,
      });
      await getCategories();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$categoryName category added")));
      Navigator.of(context).pop();
    } catch (e) {}
    isLoading = false;
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
    } on Exception catch (e) {
      // TODO
    }
  }
}
