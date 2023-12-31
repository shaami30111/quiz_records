import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/common_widgets/async_value_ui.dart';
import 'package:quiz_records/src/features/autharization/repositories/auth_model_repository.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

import '../../../common_widgets/empty_placeholder.dart';
import '../../autharization/controller/auth_controller.dart';
import '../controller/quiz_controller.dart';
import '../repositories/quiz_repository.dart';
import '../../../routing/routing.dart';
import '../widgets/quiz_card.dart';

class QuizsPage extends ConsumerWidget {
  QuizsPage({
    super.key,
  });

  checkAdmin(BuildContext context, WidgetRef ref, String userId) async {
    return await ref.read(authControllerProvider.notifier).isUserAdmin(userId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this listener is used to show alert dialog on error, while quiz is deleting
    ref.listen<AsyncValue>(
      quizControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // this provider is used to provide live list of quizs from firebase
    final streamQuizsList = ref.watch(streamQuizsListProvider);
    var user = FirebaseAuth.instance.currentUser!;
    final streamAuthmodel = ref.watch(futureAuthModelProvider(user.uid));

    // final role = checkAdmin(context, ref, user.uid);

    return Scaffold(
      appBar: AppBar(
        actions: [
          streamAuthmodel.when(
            data: (accessData) => accessData!.role!.admin == true
                ? IconButton(
                    onPressed: () {
                      context.goNamed(AppRoute.users.name);
                    },
                    icon: const Icon(Icons.admin_panel_settings),
                  )
                : const SizedBox.shrink(),
            error: (error, trace) => Text(
              error.toString(),
            ),
            loading: () => const CircularProgressIndicator(),
          ),

          // add new quiz
          IconButton(
            onPressed: () {
              context.goNamed(AppRoute.quizAdd.name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: streamQuizsList.when(
        data: (quizsList) => quizsList.isEmpty
            ? EmptyPlaceholder(
                message: 'No Quizs'.hardcoded,
              )
            : ListView.builder(
                itemCount: quizsList.length,
                // note: always create card in a separate widget file
                itemBuilder: (ctx, index) => QuizCard(
                  quiz: quizsList[index],
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
