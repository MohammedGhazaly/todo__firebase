import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_firebase/features/auths/login.dart';
import 'package:todo_firebase/features/category/add_category/add_category.dart';
import 'package:todo_firebase/features/category/category_homepage/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const Login();
                }));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddCategory();
          }));
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) {
          //   return const AddCategory();
          // }));
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      body: HomePageBody(),
    );
  }
}
