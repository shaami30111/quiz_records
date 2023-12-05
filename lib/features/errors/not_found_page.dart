import 'package:flutter/material.dart';
import 'package:quiz_records/localization/string_hardcoded.dart';

import '../../common_widgets/empty_placeholder.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmptyPlaceholder(
        message: 'Oops'.hardcoded,
        showGoHomeButton: true,
      ),
    );
  }
}
