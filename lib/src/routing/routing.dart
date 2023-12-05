import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/src/features/quiz/pages/home_screen.dart';

import '../features/autharization/pages/login_page.dart';
import '../features/errors/not_found_page.dart';
import '../features/quiz/pages/add_quiz.dart';
import '../features/quiz/pages/edit_quiz_page.dart';

enum AppRoute {
  signup,
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
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const QuizsPage(),
      ),
      GoRoute(
        path: '/quizs',
        name: AppRoute.quizs.name,
        builder: (context, state) => const QuizsPage(),
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
