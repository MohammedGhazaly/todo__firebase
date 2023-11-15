import 'package:flutter/material.dart';
import 'package:todo_firebase/features/auths/widgets/app_logo.dart';
import 'package:todo_firebase/features/auths/widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const AppLogo(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  ),
                ),
                Text(
                  "Login to continue using the app",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
