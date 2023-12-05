import 'package:quiz_records/features/quiz/repositories/quiz_repository.dart';
import 'package:quiz_records/routing/routing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/quiz.dart';


part 'quiz_controller.g.dart';

@riverpod
class QuizController extends _$QuizController {
  @override
  FutureOr<void> build() {}

  Future<bool> saveQuiz(String name, String total,String obtained) async {
    state = const AsyncValue.loading();
    // this is temp logic to create id of Quiz
    QuizID id = DateTime.now().microsecondsSinceEpoch.toString();
    final quiz = Quiz(id: id, name: name, total: total,obtained: obtained);
    final quizRepository = ref.read(quizRepositoryProvider);
    state = await AsyncValue.guard(() => quizRepository.saveQuiz(quiz));
    final success = state.hasError == false;
    if (success) {
      // goto back screen
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(goRouterProvider).pop();
    }
    return success;
  }

  Future<bool> updateQuiz(Quiz quiz, String name, String total,String obtained) async {
    state = const AsyncValue.loading();
    // Update quiz metadata (keep the old id)
    final updatedQuiz = quiz.copyWith(
      name: name,
      total: total,
      obtained: obtained,
    );
    final quizRepository = ref.read(quizRepositoryProvider);
    state =
        await AsyncValue.guard(() => quizRepository.updateQuiz(updatedQuiz));
    final success = state.hasError == false;
    if (success) {
      // goto back screen
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(goRouterProvider).pop();
    }
    return success;
  }

  Future<bool> deleteQuiz(QuizID id) async {
    state = const AsyncLoading();
    final quizRepository = ref.read(quizRepositoryProvider);
    state = await AsyncValue.guard(() => quizRepository.deleteQuiz(id));
    return state.hasError == false;
  }
}
