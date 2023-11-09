import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/views/auths/auth_provider/auth_provider.dart';
import 'package:todo_firebase/views/auths/signup.dart';
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomFormTextField(
            textEditingController: emailController,
            hintText: "Enter your email",
            labelText: "Email",
            validatorFunction: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email should not be empty.";
              }
              if (!EmailValidator.validate(value)) {
                return "Please enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormTextField(
              textEditingController: passwordController,
              hintText: "Enter your password",
              labelText: "Password",
              obsuceText: true,
              validatorFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Password should not be empty.";
                }
                if (value.length < 6) {
                  return "Enter at least 6 chars";
                }
                return null;
              }),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  if (emailController.text.trim().isNotEmpty &&
                      EmailValidator.validate(emailController.text)) {
                    await authProvider.resetEmail(
                        emailController.text, context);
                  }
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          CustomAuthButton(
              text: "Login",
              isLoading: authProvider.isRegistering,
              onPressedFunction: () async {
                if (formKey.currentState!.validate()) {
                  await authProvider.login(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context);
                }
              }),
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
              icon: const FaIcon(FontAwesomeIcons.google),
              onPressedFunction: () async {
                await authProvider.signInWithGoogle(context);
              }),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const SignUp();
              }));
            },
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    // recognizer: TapGestureRecognizer()
                    //   ..onTap = () => print("object"),
                    text: "Register",
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
