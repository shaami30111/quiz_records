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

  Future<String> signIn(String email, String password) async {
    state = const AsyncValue.loading();

    final authRepository = ref.read(authRepositoryProvider);
    var result =
        await AsyncValue.guard(() => authRepository.signIn(email, password));
    // final success = state.hasError == false;
    var temp;

    result.whenData((value) => temp = value[1]);
    bool isLogged = temp['isLogged'];
    if (isLogged) {
      final success = state.hasError == false;
      // goto back screen
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      var role;
      result.whenData((value) => role = value[0]);

      print("inside controller:   $role");
      ref.read(goRouterProvider).goNamed(
        AppRoute.home.name,
        pathParameters: {
          "admin": role['admin'].toString(),
        },
      );
      return temp['isLogged'].toString();
    }
    String? errorValue;
    result.whenData((value) => errorValue = value[0]['isLogged']);
    state = const AsyncValue.data(null);
    return errorValue ?? "Error!";
  }
}
