import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/auth_model.dart';
import '../repo/auth_model_repository.dart';
import '../routing.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<bool> saveAuth(AuthModel auth, User user) async {
    state = const AsyncValue.loading();
    // this is temp logic to create id of Quiz
    final authRepository = ref.read(authRepositoryProvider);
    state =
        await AsyncValue.guard(() => authRepository.saveAuthModel(auth, user));
    final success = state.hasError == false;
    if (success) {
      
    }
    return success;
  }
}
