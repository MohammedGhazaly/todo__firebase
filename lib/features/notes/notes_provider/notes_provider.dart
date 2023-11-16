import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot> notes = [];
  bool isConnecting = true;
  bool isFetching = true;
  bool isAdding = false;
  bool isUpdating = false;

  Future<void> getNotes(BuildContext context, final categoryId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    isConnecting = true;

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      notes = [];
      try {
        isFetching = true;
        notifyListeners();
        QuerySnapshot notesSnapShot = await FirebaseFirestore.instance
            .collection("categories")
            .doc(categoryId)
            .collection("notes")
            .get();

        // for (var element in notesSnapShot.docs) {
        //   notes.add(element);
        // }
        notes.addAll(notesSnapShot.docs);
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

  Future<void> addNote(
      {required String categoryId,
      required String note,
      required BuildContext context}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isAdding = true;
      notifyListeners();
      try {
        DocumentReference response = await FirebaseFirestore.instance
            .collection("categories")
            .doc(categoryId)
            .collection("notes")
            .add({"note": note});
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text(" Note added")));
        await getNotes(context, categoryId);
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

  Future<void> removeNote(
      {context, required String categoryId, required String noteId}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // await categoriesCollection.doc(categoryId).delete();
        await FirebaseFirestore.instance
            .collection("categories")
            .doc(categoryId)
            .collection("notes")
            .doc(noteId)
            .delete();
        await getNotes(context, categoryId);
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No internet connection")));
      isConnecting = false;
    }
  }

  Future<void> editNote({
    required BuildContext context,
    required String categoryId,
    required String newNote,
    required String noteId,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        isUpdating = true;
        notifyListeners();

        await FirebaseFirestore.instance
            .collection("categories")
            .doc(categoryId)
            .collection("notes")
            .doc(noteId)
            .update({
          "note": newNote,
        });
        // await categoriesCollection.doc(categoryId).update({
        //   "name": newName,
        // });

        if (!context.mounted) return;
        await getNotes(context, categoryId);
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
