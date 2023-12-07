import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/src/common_widgets/async_value_ui.dart';
import 'package:quiz_records/src/features/autharization/controller/auth_controller.dart';
import 'package:quiz_records/src/features/autharization/model/auth_model.dart';
import 'package:quiz_records/src/features/autharization/widgets/auth_validator.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

class EditRolePageContent extends ConsumerWidget {
  EditRolePageContent({
    super.key,
    required this.authModel,
  });
  final AuthModel authModel;
  final formKey = GlobalKey<FormState>();
  final adminController = TextEditingController();
  final moderatorController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this listener is used to show alert dialog on error, while quiz is updating
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // this controller is used to check loader state, while quiz is updating
    final authController = ref.watch(authControllerProvider);
    final isLoading = authController.isLoading;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit User Role'.hardcoded),
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("User Email.: ${authModel.email} ".hardcoded),
                Text("Roles:".hardcoded),
                TextFormField(
                  enabled: !isLoading,
                  controller: adminController
                    ..text = authModel.role!.admin.toString(),
                  validator: (value) =>
                      ref.read(authValidatorProvider).boolValidator(value!),
                  decoration: InputDecoration(
                    label: Text('Admin'.hardcoded),
                  ),
                ),
                TextFormField(
                  enabled: !isLoading,
                  controller: moderatorController
                    ..text = authModel.role!.moderator.toString(),
                  validator: (value) =>
                      ref.read(authValidatorProvider).boolValidator(value!),
                  decoration: InputDecoration(
                    label: Text('Moderator'.hardcoded),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    _updateUser(context, ref);
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text('Update User'.hardcoded),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _updateUser(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      Role newRole = Role(
        admin: adminController.text == "true" ? true : false,
        moderator: moderatorController.text == "true" ? true : false,
      );
      final success =
          await ref.read(authControllerProvider.notifier).updateRole(
                authModel.userId!,
                newRole,
              );
      // show success msg to user, don't show msg on console
      if (success) {
        // Inform the user that the quiz has been updated
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'User Role successfully updated'.hardcoded,
            ),
          ),
        );
      }
    }
  }
}
