import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/features/autharization/pages/login_page.dart';
import 'package:quiz_records/src/features/quiz/pages/home_screen.dart';

import '../features/autharization/pages/signup_page.dart';
import '../features/errors/not_found_page.dart';
import '../features/quiz/pages/add_quiz.dart';
import '../features/quiz/pages/edit_quiz_page.dart';

enum AppRoute {
  signup,
  login,
  home,
  quizs,
  quizAdd,
  quizEdit,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.signup.name,
        builder: (context, state) => SignupPage(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/home:role',
        name: AppRoute.home.name,
        pageBuilder: (context, state) {
          final role = state.pathParameters['role']!;
          return MaterialPage(
            fullscreenDialog: true,
            child: QuizsPage(role),
          );
        },
      ),
      GoRoute(
        path: '/quizs:role',
        name: AppRoute.quizs.name,
        pageBuilder: (context, state) {
          final role = state.pathParameters['role']!;
          return MaterialPage(
            fullscreenDialog: true,
            child: QuizsPage(role),
          );
        },
        routes: [
          GoRoute(
            path: 'add',
            name: AppRoute.quizAdd.name,
            pageBuilder: (context, state) => MaterialPage(
              fullscreenDialog: true,
              child: AddQuizPage(),
            ),
          ),
          GoRoute(
            path: 'edit/:id',
            name: AppRoute.quizEdit.name,
            pageBuilder: (context, state) {
              final quizId = state.pathParameters['id']!;
              return MaterialPage(
                fullscreenDialog: true,
                child: EditQuizPage(id: quizId),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
});
