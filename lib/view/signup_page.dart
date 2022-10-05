import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'widgets.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              key: formKey,
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Authentication',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const CommonSizedBox(),
                  TextFormField(
                    obscureText: true,
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value != null && !EmailValidator.validate(value)
                            ? 'Enter a valid mail'
                            : null,
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
                    controller: passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
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
                          onPressed: () async {
                            await signUp(context);
                          },
                          child: const Text('Sign Up'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp(context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        log('dfd');
        FirebaseAuth.instance.signOut();
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      return;
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
