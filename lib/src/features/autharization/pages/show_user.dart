import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/common_widgets/async_value_ui.dart';
import 'package:quiz_records/src/features/autharization/controller/auth_controller.dart';
import 'package:quiz_records/src/features/autharization/repositories/auth_model_repository.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';
import 'package:quiz_records/src/routing/routing.dart';

import '../../../common_widgets/empty_placeholder.dart';
import '../widgets/auth_card.dart';

class UsersPage extends ConsumerWidget {
  UsersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this listener is used to show alert dialog on error, while quiz is deleting
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // this provider is used to provide live list of quizs from firebase
    final streamauthsList = ref.watch(streamAuthModelsListProvider);
    var user = FirebaseAuth.instance.currentUser!;

    // final role = checkAdmin(context, ref, user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Access Control".hardcoded),
        // actions: [

        //   // add new quiz
        //   IconButton(
        //     onPressed: () {
        //       context.goNamed(AppRoute.quizAdd.name);
        //     },
        //     icon: const Icon(Icons.add),
        //   ),
        // ],
      ),
      body: streamauthsList.when(
        data: (accessList) => accessList.isEmpty
            ? EmptyPlaceholder(
                message: 'No User Access Registered'.hardcoded,
              )
            : ListView.builder(
                itemCount: accessList.length,
                // note: always create card in a separate widget file
                itemBuilder: (ctx, index) => AuthCard(
                  authModel: accessList[index],
                  userId: accessList[index].userId!,
                  ref: ref,
                ),
              ),
        error: (error, trace) => Text(
          error.toString(),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseAuth.instance.signOut();
            print('User successfully signed out');
            context.goNamed(AppRoute.login.name);
          } else {
            print('No user is currently signed in');
          }
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }
}
