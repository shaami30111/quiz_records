import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/localization/string_hardcoded.dart';

import '../../../common_widgets/empty_placeholder.dart';
import '../model/quiz.dart';

import '../repo/quiz_repository.dart';
import 'edit_quiz_page_content.dart';


class EditQuizPage extends ConsumerWidget {
  const EditQuizPage({super.key, required this.id});
  final QuizID id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this controller is used to get & show live quiz data
    final streamQuiz = ref.watch(streamQuizProvider(id));
    return streamQuiz.when(
      data: (quiz) => quiz != null
          ? EditQuizPageContent(
              quiz: quiz,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Quiz'.hardcoded),
              ),
              body: EmptyPlaceholder(
                message: 'Quiz not found'.hardcoded,
              ),
            ),
      error: (error, trace) => Text(
        error.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
