import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_firebase/features/auths/login.dart';
import 'package:todo_firebase/features/category/category_homepage/home_page.dart';

class AuthProvider extends ChangeNotifier {
  bool isRegistering = false;
  Future<void> register(
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
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Login();
      }));
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No internet")));
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("asd")));
      isRegistering = false;
    }
    isRegistering = false;
    notifyListeners();
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      isRegistering = true;
      notifyListeners();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isRegistering = false;

      if (!context.mounted) return;

      if (userCredential.user!.emailVerified) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Welcome to TODO")));
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please verify email before login.")));
      }
    } on SocketException catch (e) {
      print("Ok");

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No internet")));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      isRegistering = false;
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Wrong email or password.")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, try again later.")));
      isRegistering = false;
    }
    isRegistering = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (!context.mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  Future<void> resetEmail(String email, BuildContext context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Check $email to rest password.")));

    //   try {

    //   } catch (e) {
    //     print("Error");
    //   }
    // }
  }
}
