import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/src/constants/app_sizes.dart';
import 'package:quiz_records/src/features/autharization/controller/auth_controller.dart';
import 'package:quiz_records/src/features/autharization/model/auth_model.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

import '../../../routing/routing.dart';


class SignupPage extends ConsumerWidget {
  SignupPage({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedRole;

  Future<void> signUpToAuth(BuildContext context, WidgetRef ref) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Access the newly created user via userCredential.user
      User? user = userCredential.user;
      var uid = userCredential.user?.uid;
      // You can add additional actions after successful sign-up
      print("Sign-up successful! User ID: ${user?.uid}");
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      AuthModel auth = AuthModel(
        email: emailController.text,
        userRole: selectedRole,
      );
      print("Before database");

      final success =
          await ref.read(authControllerProvider.notifier).saveAuth(auth, uid!);
      // show success msg to user, don't show msg on console
      print(success);
      if (success) {
        // Inform the user that the quiz has been updated
        print("Return from database");
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'User successfully created'.hardcoded,
            ),
          ),
        );
        ref.read(goRouterProvider).goNamed(AppRoute.home.name);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error6666: ${e.message}');
      }
    } catch (e) {
      print('Errorfhfhfhfh: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'.hardcoded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name'.hardcoded,
              ),
            ),
            gapH16,
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email'.hardcoded,
              ),
            ),
            gapH16,
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password'.hardcoded,
              ),
            ),
            gapH16,
            DropdownButton<String>(
              value: selectedRole,
              hint: Text("Select Role".hardcoded),
              items: ['Student'.hardcoded, 'Teacher'.hardcoded].map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  selectedRole = value;
                  print(selectedRole);
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                signUpToAuth(context, ref);
              },
              child: Text('Sign Up'.hardcoded),
            ),
          ],
        ),
      ),
    );
  }
}
