import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/common_widgets/async_value_ui.dart';
import 'package:quiz_records/src/constants/app_sizes.dart';
import 'package:quiz_records/src/features/autharization/controller/auth_controller.dart';
import 'package:quiz_records/src/features/autharization/widgets/auth_validator.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

import '../../../routing/routing.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final authController = ref.watch(authControllerProvider);
    final isLoading = authController.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'.hardcoded),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                enabled: !isLoading,
                controller: emailController,
                validator: (value) =>
                    ref.read(authValidatorProvider).emailValidator(value),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email'.hardcoded,
                ),
              ),
              gapH16,
              TextFormField(
                enabled: !isLoading,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password'.hardcoded,
                ),
              ),
              gapH16,
              TextButton(
                onPressed: () => signInWithEmailAndPassword(context, ref),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text('Sign In'.hardcoded),
              ),
              gapH24,
              TextButton(
                onPressed: () => context.goNamed(AppRoute.signup.name),
                child: Text('Sign Up'.hardcoded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final success = await ref.read(authControllerProvider.notifier).signIn(
            emailController.text,
            passwordController.text,
          );
      // show success msg to user, don't show msg on console
      if (success == "true" || success == "no role") {
        // Inform the user that the login was success
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'User successfully LoggedIn'.hardcoded,
            ),
          ),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              success.hardcoded,
            ),
          ),
        );
      }
    }
  }
}
