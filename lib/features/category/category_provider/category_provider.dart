import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/features/category/category_homepage/home_page.dart';

class CategoryProvider extends ChangeNotifier {
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  bool isAdding = false;
  bool isFetching = true;
  bool isUpdating = false;
  List<QueryDocumentSnapshot> categories = [];
  bool isConnecting = true;
  Future<void> addCategory(
      {required String categoryName,
      required String userId,
      required BuildContext context}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isAdding = true;
      notifyListeners();
      try {
        DocumentReference response = await categoriesCollection.add({
          "name": categoryName,
          "id": userId,
        });
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$categoryName category added")));
        await getCategories(context);
        if (!context.mounted) return;

        Navigator.pop(context);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //   return const HomePage();

        // }));
      } catch (e) {}
      isAdding = false;
      notifyListeners();
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
    }
  }

  Future<void> getCategories(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      categories = [];
      try {
        isFetching = true;
        notifyListeners();
        QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
            .collection("categories")
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
        for (var element in categoriesSnapshot.docs) {
          categories.add(element);
        }
      } on Exception catch (e) {
        // TODO
      }
      isFetching = false;
      notifyListeners();
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
      notifyListeners();
    }
  }

  Future<void> removeCategory(context, String categoryId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        await categoriesCollection.doc(categoryId).delete();
        await getCategories(context);
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
    }
  }

  Future<void> editCateogry(
      {required BuildContext context,
      required String categoryId,
      required String newName}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        isUpdating = true;
        notifyListeners();
        await categoriesCollection.doc(categoryId).update({
          "name": newName,
        });

        if (!context.mounted) return;
        await getCategories(context);
        if (!context.mounted) return;
        Navigator.pop(context);
      } catch (e) {}
      isUpdating = false;
      notifyListeners();
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
      notifyListeners();
    }
  }
}
