import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/views/homepage/home_page.dart';

class AuthProvider extends ChangeNotifier {
  bool isRegistering = false;
  void register(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      isRegistering = true;
      notifyListeners();

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      isRegistering = false;

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } on FirebaseAuthException catch (e) {
      isRegistering = false;
      if (e.code == 'weak-password') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password should be at least 6 chars")));
      } else if (e.code == 'email-already-in-use') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email is already used")));
      }
    } catch (e) {
      isRegistering = false;
    }
    isRegistering = false;
    notifyListeners();
  }
}
