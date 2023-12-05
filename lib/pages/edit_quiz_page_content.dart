import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/common_widgets/async_value_ui.dart';
import 'package:quiz_records/localization/string_hardcoded.dart';

import '../controller/quiz_controller.dart';
import '../model/quiz.dart';
import '../widgets/quiz_validator.dart';

class EditQuizPageContent extends ConsumerWidget {
  EditQuizPageContent({
    super.key,
    required this.quiz,
  });
  final Quiz quiz;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final totalController = TextEditingController();
  final obtainedController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this listener is used to show alert dialog on error, while quiz is updating
    ref.listen<AsyncValue>(
      quizControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // this controller is used to check loader state, while quiz is updating
    final quizController = ref.watch(quizControllerProvider);
    final isLoading = quizController.isLoading;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Quiz'.hardcoded),
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  enabled: !isLoading,
                  controller: nameController..text = quiz.name,
                  validator: (value) =>
                      ref.read(quizValidatorProvider).nameValidator(value),
                  decoration: InputDecoration(
                    label: Text('Name'.hardcoded),
                  ),
                ),
                TextFormField(
                  enabled: !isLoading,
                  controller: totalController..text = quiz.total,
                  validator: (value) =>
                      ref.read(quizValidatorProvider).totalValidator(value),
                  decoration: InputDecoration(
                    label: Text('Total'.hardcoded),
                  ),
                ),
                TextFormField(
                  enabled: !isLoading,
                  controller: obtainedController..text = quiz.obtained,
                  validator: (value) =>
                      ref.read(quizValidatorProvider).obtainedValidator(value),
                  decoration: InputDecoration(
                    label: Text('Obtained'.hardcoded),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    _updateQuiz(context, ref);
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text('Update Quiz'.hardcoded),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _updateQuiz(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final success =
          await ref.read(quizControllerProvider.notifier).updateQuiz(
                quiz,
                nameController.text,
                totalController.text,
                obtainedController.text,
              );
      // show success msg to user, don't show msg on console
      if (success) {
        // Inform the user that the quiz has been updated
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'Quiz successfully updated'.hardcoded,
            ),
          ),
        );
      }
    }
  }
}
