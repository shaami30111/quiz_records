import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/src/localization/string_hardcoded.dart';

/// A class with some product validation methods
class AuthValidator {
  const AuthValidator();

  String? boolValidator(String role) {
    if (role == "true" || role == "false") {
      return null;
    } else {
      return "Role status can only be 'true' or 'false'.".hardcoded;
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email can\'t be empty'.hardcoded;
    }

    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format'.hardcoded;
    }

    // Check if '@' is present
    if (!value.contains('@')) {
      return 'Email must contain @'.hardcoded;
    }

    // Check if '.com' is present
    if (!value.toLowerCase().contains('.com')) {
      return 'Email must end with .com'.hardcoded;
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password can\'t be empty'.hardcoded;
    }

    // Check if the password has at least 8 characters
    if (value.length < 8) {
      return 'Password must be 8 characters or longer'.hardcoded;
    }

    // Check if the password contains at least one uppercase letter, one lowercase letter, one number, and one symbol
    final RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    final RegExp lowercaseRegExp = RegExp(r'[a-z]');
    final RegExp numberRegExp = RegExp(r'[0-9]');
    final RegExp symbolRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!uppercaseRegExp.hasMatch(value) ||
        !lowercaseRegExp.hasMatch(value) ||
        !numberRegExp.hasMatch(value) ||
        !symbolRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one symbol'
          .hardcoded;
    }

    return null;
  }
}

final authValidatorProvider = Provider<AuthValidator>((ref) {
  return const AuthValidator();
});
