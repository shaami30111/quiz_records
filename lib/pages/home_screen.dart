import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/common_widgets/async_value_ui.dart';
import 'package:quiz_records/localization/string_hardcoded.dart';

import '../common_widgets/empty_placeholder.dart';
import '../controller/quiz_controller.dart';
import '../repo/quiz_repository.dart';
import '../routing.dart';
import '../widgets/quiz_card.dart';

class QuizsPage extends ConsumerWidget {
  const QuizsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this listener is used to show alert dialog on error, while quiz is deleting
    ref.listen<AsyncValue>(
      quizControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // this provider is used to provide live list of quizs from firebase
    final streamQuizsList = ref.watch(streamQuizsListProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
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
    );
  }
}
