import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_records/localization/string_hardcoded.dart';

import '../constants/app_sizes.dart';
import '../routing/routing.dart';


/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    super.key,
    required this.message,
    this.showGoHomeButton = false,
  });
  final String message;
  final bool showGoHomeButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: showGoHomeButton
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  gapH32,
                  TextButton(
                    onPressed: () => context.goNamed(AppRoute.home.name),
                    child: Text('Go Home'.hardcoded),
                  )
                ],
              )
            : Text(
                message,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
