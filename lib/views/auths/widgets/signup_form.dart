import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/views/auths/auth_provider/auth_provider.dart';
import 'package:todo_firebase/views/auths/login.dart';
import 'package:todo_firebase/views/auths/widgets/custom_auth_button.dart';
import 'package:todo_firebase/views/auths/widgets/form_text_field.dart';
import 'package:email_validator/email_validator.dart';

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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: Column(
        children: [
          CustomFormTextField(
            textEditingController: userNameController,
            hintText: "Enter your username",
            labelText: "Username",
            validatorFunction: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Username should not be empty.";
              } else if (value.length < 3) {
                return "User should be at least 3 chars.";
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
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
            },
          ),
          const SizedBox(
            height: 24,
          ),
          CustomAuthButton(
              text: "Signup",
              isLoading: authProvider.isRegistering,
              onPressedFunction: () async {
                if (formKey.currentState!.validate()) {
                  await authProvider.register(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context);
                }
              }),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const Login();
              }));
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
