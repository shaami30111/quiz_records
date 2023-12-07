import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/src/common_widgets/empty_placeholder.dart';
import 'package:quiz_records/src/features/autharization/repositories/auth_model_repository.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

import 'edit_role_content.dart';

class EditRolePage extends ConsumerWidget {
  const EditRolePage({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this controller is used to get & show live quiz data
    final streamAuth = ref.watch(streamAuthModelProvider(userId));
    return streamAuth.when(
      data: (authmodel) => authmodel != null
          ? EditRolePageContent(
              authModel: authmodel,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit User Role'.hardcoded),
              ),
              body: EmptyPlaceholder(
                message: 'User not found'.hardcoded,
              ),
            ),
      error: (error, trace) => Text(
        error.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
