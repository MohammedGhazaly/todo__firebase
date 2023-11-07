import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_firebase/views/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/views/auths/widgets/custom_auth_button_with_icon.dart';
import 'package:todo_firebase/views/auths/widgets/form_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
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
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          CustomAuthButton(text: "Login", onPressedFunction: () {}),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Or login with",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomAuthButtonWithIcon(
              text: "Login with google",
              icon: FaIcon(FontAwesomeIcons.google),
              onPressedFunction: () {}),
          const SizedBox(
            height: 10,
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: "Don't have an account? "),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => print("object"),
                  text: "Register",
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
