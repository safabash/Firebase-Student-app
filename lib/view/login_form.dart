import 'dart:developer';

import 'package:authentication/main.dart';
import 'package:authentication/view/signup_page.dart';
import 'package:authentication/view/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/firebaselogo.png',
                          height: 100,
                        ),
                        const CommonSizedBox(),
                        const Text(
                          'Firebase',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Authentication',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const CommonSizedBox(),
                        TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && !EmailValidator.validate(value)
                                  ? 'Enter a valid mail'
                                  : null,
                          obscureText: true,
                          decoration: const InputDecoration(
                              label: Text('username'),
                              hintText: 'Enter your username',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const Divider(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter minimum 6 characters'
                                  : null,
                          decoration: const InputDecoration(
                              label: Text('password'),
                              hintText: 'Enter the password',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                            width: double.maxFinite,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  signIn(context);
                                },
                                child: const Text('Sign In'))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              width: (size / 2) - 40,
                              child: const Divider(),
                            ),
                            const Text(
                              'Or',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: (size / 2) - 40,
                              child: const Divider(),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: double.maxFinite,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: const Text('Sign Up'))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future signIn(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      Utils.showSnackBar(e.message);
      return;
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
