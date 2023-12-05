import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

import '../../../common_widgets/alert_dialogs.dart';
import '../controller/quiz_controller.dart';
import '../model/quiz.dart';
import '../../../routing/routing.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz, required this.ref});
  final Quiz quiz;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(quiz.name),
        subtitle:
            Text("Total: ${quiz.total} <-----> Obtained: ${quiz.obtained}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.goNamed(
                  AppRoute.quizEdit.name,
                  pathParameters: {'id': quiz.id},
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                _deleteQuiz(context, ref, quiz.id);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteQuiz(BuildContext context, WidgetRef ref, QuizID id) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final delete = await showAlertDialog(
      context: context,
      title: 'Are you sure?'.hardcoded,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: 'Delete'.hardcoded,
    );
    if (delete == true) {
      final success =
          await ref.read(quizControllerProvider.notifier).deleteQuiz(id);
      if (success) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'Quiz successfully deleted'.hardcoded,
            ),
          ),
        );
      }
    }
  }
}
