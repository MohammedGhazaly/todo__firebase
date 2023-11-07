import 'package:flutter/material.dart';
import 'package:todo_firebase/views/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/views/auths/widgets/form_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomFormTextField(
            textEditingController: userNameController,
            hintText: "Enter your username",
            labelText: "Username",
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormTextField(
            textEditingController: emailController,
            hintText: "Enter your email",
            labelText: "Email",
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormTextField(
            textEditingController: passwordController,
            hintText: "Enter your password",
            labelText: "Password",
          ),
          const SizedBox(
            height: 24,
          ),
          CustomAuthButton(text: "Signup", onPressedFunction: () {}),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    // recognizer: TapGestureRecognizer()
                    //   ..onTap = () => print("object"),
                    text: "Login",
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
