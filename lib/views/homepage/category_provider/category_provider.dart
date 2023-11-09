import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider extends ChangeNotifier {
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  bool isLoading = false;
  Future<void> addCategory(
      {required String categoryName, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      DocumentReference response = await categories.add({
        "name": categoryName,
      });
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$categoryName category added")));
      Navigator.of(context).pop();
    } catch (e) {}
    isLoading = false;
    notifyListeners();
  }
}
