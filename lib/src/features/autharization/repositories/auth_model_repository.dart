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
        "userId": authModel.userId,
        "email": authModel.email,
        "role": authModel.role?.toJson(),
      },
      SetOptions(merge: true),
    );
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // Handle invalid user credentials
        return false;
      } else {
        // Handle other exceptions
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static String authModelsPath() => 'access_roles';

  Future<List<AuthModel>> futureAuthModelsList() async {
    final ref = _authModelsRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => (docSnapshot.data())).toList();
  }

  Stream<List<AuthModel>> streamAuthModelsList() {
    final ref = _authModelsRef();
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => (docSnapshot.data())).toList());
  }

  Future<AuthModel?> futureAuthModel(String userId) async {
    final ref = _authModelRef(userId);
    final snapshot = await ref.get();
    return (snapshot.data());
  }

  Stream<AuthModel?> streamAuthModel(String userId) {
    final ref = _authModelRef(userId);
    return ref.snapshots().map((snapshot) => (snapshot.data()));
  }

  Future<void> updateAuthModel(AuthModel authModel, String userId) {
    final ref = _authModelRef(userId);
    return ref.set(authModel);
  }

  Future<void> deleteAuthModel(String userId) {
    return _firestore.doc(authPath(userId)).delete();
  }

  DocumentReference<AuthModel> _authModelRef(String userId) =>
      _firestore.doc(authPath(userId)).withConverter(
            fromFirestore: (doc, _) => AuthModel.fromJson(doc.data()!),
            toFirestore: (AuthModel authModel, options) => authModel.toJson(),
          );

  Query<AuthModel> _authModelsRef() => _firestore
      .collection(authModelsPath())
      .withConverter(
        fromFirestore: (doc, _) => AuthModel.fromJson(doc.data()!),
        toFirestore: (AuthModel authModel, options) => authModel.toJson(),
      )
      .orderBy('userId');

  // Additional methods...

  // Example search function
  Future<List<AuthModel>> search(String query) async {
    final authModelsList = await futureAuthModelsList();
    return authModelsList
        .where((authModel) =>
            authModel.email!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<bool> isUserAdmin(String userId) async {
    final authModel = await futureAuthModel(userId);
    return authModel?.role?.admin ?? false;
  }

  Future<bool> isUserModerator(String userId) async {
    final authModel = await futureAuthModel(userId);
    return authModel?.role?.moderator ?? false;
  }

  Future<void> updateRole(String userId, Role newRole) async {
    final authModel = await futureAuthModel(userId);

    if (authModel != null) {
      authModel.role = newRole;
      await updateAuthModel(authModel, userId);
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

@riverpod
Stream<List<AuthModel>> streamAuthModelsList(StreamAuthModelsListRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.streamAuthModelsList();
}

@riverpod
Future<List<AuthModel>> futureAuthModelsList(FutureAuthModelsListRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.futureAuthModelsList();
}

@riverpod
Stream<AuthModel?> streamAuthModel(StreamAuthModelRef ref, String userId) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.streamAuthModel(userId);
}

@riverpod
Future<AuthModel?> futureAuthModel(FutureAuthModelRef ref, String userId) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.futureAuthModel(userId);
}
