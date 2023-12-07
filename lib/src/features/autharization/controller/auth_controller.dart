import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../routing/routing.dart';
import '../model/auth_model.dart';
import '../repositories/auth_model_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<bool> saveAuth(AuthModel auth, String user) async {
    state = const AsyncValue.loading();
    // this is temp logic to create id of Quiz
    final authRepository = ref.read(authRepositoryProvider);
    state =
        await AsyncValue.guard(() => authRepository.saveAuthModel(auth, user));
    final success = state.hasError == false;
    if (success) {
      print("contoller success");
    }
    return success;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncValue.loading();

    final authRepository = ref.read(authRepositoryProvider);
    var result =
        await AsyncValue.guard(() => authRepository.signIn(email, password));
    // final success = state.hasError == false;
    bool isLogged = false;

    result.whenData((value) => isLogged = value);

    if (isLogged) {
      final success = state.hasError == false;
      // goto back screen
      // ignore: avoid_manual_providers_as_generated_provider_dependency

      ref.read(goRouterProvider).goNamed(
            AppRoute.home.name,
          );
      return isLogged;
    }
    state = const AsyncValue.data(null);
    return false;
  }

  Future<bool> deleteUserRole(String userId) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state =
        await AsyncValue.guard(() => authRepository.deleteAuthModel(userId));
    return state.hasError == false;
  }

  Future<bool> isUserAdmin(String userId) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(() => authRepository.isUserAdmin(userId));
    return state.hasError == false;
  }

  Future<bool> isUserModerator(String userId) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state =
        await AsyncValue.guard(() => authRepository.isUserModerator(userId));
    return state.hasError == false;
  }

  Future<bool> updateRole(String userId, Role newRole) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
        () => authRepository.updateRole(userId, newRole));
    final success = state.hasError == false;
    if (success) {
      // goto back screen
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(goRouterProvider).pop();
    }
    return success;
  }
}
