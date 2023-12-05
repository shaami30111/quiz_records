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
}

// this is Riverpod provider, named: quizRepositoryProvider
// just create instance of QuizRepository class
// this instance perform CRUD operation on firestore
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseFirestore.instance);
}
