import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/auth_model.dart';

part 'auth_model_repository.g.dart';

class AuthRepository {
  // class constructor
  const AuthRepository(this._firestore);
  // class variable
  final FirebaseFirestore _firestore;
  static String authPath(String id) => 'access_roles/$id';

  Future<void> saveAuthModel(AuthModel authModel, String user) async {
    print("before writing");
    return _firestore.doc(authPath(user)).set(
      {
        "email": authModel.email,
        "role": authModel.userRole,
      },
      SetOptions(merge: true),
    );
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      if (user != null) {
        // Fetch the user's custom claims
        IdTokenResult idTokenResult = await user.getIdTokenResult();
        Map<String, dynamic>? claims = idTokenResult.claims;

        // Check if the 'role' claim is present
        if (claims != null && claims.containsKey('role')) {
          // Extract the user's role from the claims
          String role = claims['role'];

          print('User has role: $role');
          return role;
        } else {
          print('User does not have a role claim');
          return "no role";
        }
      }
      return "no role";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // Handle invalid user credentials
        return "Invalid email or password. Please try again.";
      } else {
        // Handle other exceptions
        return "Other Exceptions ${e.message}";
      }
    } catch (e) {
      return "Error $e";
    }
  }
}

// this is Riverpod provider, named: quizRepositoryProvider
// just create instance of QuizRepository class
// this instance perform CRUD operation on firestore
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseFirestore.instance);
}
