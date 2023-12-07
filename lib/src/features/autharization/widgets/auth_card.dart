import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/features/autharization/controller/auth_controller.dart';
import 'package:quiz_records/src/features/autharization/model/auth_model.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

import '../../../common_widgets/alert_dialogs.dart';
import '../../../routing/routing.dart';

class AuthCard extends StatelessWidget {
  const AuthCard(
      {super.key,
      required this.authModel,
      required this.ref,
      required this.userId});
  final AuthModel authModel;
  final String userId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("User Email.: ${authModel.email} ".hardcoded),
        subtitle: Column(
          children: [
            Text("Roles:".hardcoded),
            Text("Role: Administrator <----->Status: ${authModel.role!.admin}"),
            Text("Role: Moderator <----->Status: ${authModel.role!.moderator}"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.goNamed(
                  AppRoute.userEdit.name,
                  pathParameters: {'userId': authModel.userId!},
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                _deleteQuiz(context, ref, authModel.userId!);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteQuiz(BuildContext context, WidgetRef ref, String id) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final delete = await showAlertDialog(
      context: context,
      title: 'Are you sure?'.hardcoded,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: 'Delete'.hardcoded,
    );
    if (delete == true) {
      final success =
          await ref.read(authControllerProvider.notifier).deleteUserRole(id);
      if (success) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'User Role successfully deleted'.hardcoded,
            ),
          ),
        );
      }
    }
  }
}
