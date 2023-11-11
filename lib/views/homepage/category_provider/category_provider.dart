import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/views/homepage/home_page.dart';

class CategoryProvider extends ChangeNotifier {
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  bool isAdding = false;
  bool isFetching = true;
  List<QueryDocumentSnapshot> categories = [];
  bool isConnecting = true;
  Future<void> addCategory(
      {required String categoryName, required BuildContext context}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isAdding = true;
      notifyListeners();
      try {
        DocumentReference response = await categoriesCollection.add({
          "name": categoryName,
        });

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$categoryName category added")));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } catch (e) {}
      isAdding = false;
      notifyListeners();
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
      notifyListeners();
    }
  }

  Future<void> getCategories(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      categories = [];
      try {
        QuerySnapshot categoriesSnapshot =
            await FirebaseFirestore.instance.collection("categories").get();

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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } catch (e) {
        print(e);
      }
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
      notifyListeners();
    }
  }
}
