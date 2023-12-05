import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/quiz.dart';


part 'quiz_repository.g.dart';

// this is Quiz class
// this class will perform CRUD opertion on firestore
class QuizRepository {
  // class constructor
  const QuizRepository(this._firestore);
  // class variable
  final FirebaseFirestore _firestore;

  // return path of List<Quiz>
  static String quizsPath() => 'quizs';
  // return path of single Quiz
  static String quizPath(QuizID id) => 'quizs/$id';

  // return List<Quiz> in Future
  Future<List<Quiz>> futureQuizsList() async {
    final ref = _quizsRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  // return List<Quiz> in live data stream
  Stream<List<Quiz>> streamQuizsList() {
    final ref = _quizsRef();
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  // return single quiz in future
  Future<Quiz?> futureQuiz(QuizID id) async {
    final ref = _quizRef(id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  // return single quiz in live stream
  Stream<Quiz?> streamQuiz(QuizID id) {
    final ref = _quizRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  // create new quiz
  Future<void> saveQuiz(Quiz quiz) {
    return _firestore.doc(quizPath(quiz.id)).set(
      {
        'id': quiz.id,
        'name': quiz.name,
        'total': quiz.total,
        'obtained':quiz.obtained,
      },
      // use merge: true to keep old fields (if any)
      SetOptions(merge: true),
    );
  }

  // update old quiz
  Future<void> updateQuiz(Quiz quiz) {
    final ref = _quizRef(quiz.id);
    return ref.set(quiz);
  }

  // delete quiz
  Future<void> deleteQuiz(QuizID id) {
    return _firestore.doc(quizPath(id)).delete();
  }

  // helper function for update and get single quiz
  DocumentReference<Quiz> _quizRef(QuizID id) =>
      _firestore.doc(quizPath(id)).withConverter(
            fromFirestore: (doc, _) => Quiz.fromMap(doc.data()!),
            toFirestore: (Quiz quiz, options) => quiz.toMap(),
          );

  // helper function for update and get list of quizs
  Query<Quiz> _quizsRef() => _firestore
      .collection(quizsPath())
      .withConverter(
        fromFirestore: (doc, _) => Quiz.fromMap(doc.data()!),
        toFirestore: (Quiz quiz, options) => quiz.toMap(),
      )
      .orderBy('id');

  // * Temporary search implementation.
  // * Note: this is quite inefficient as it pulls the entire Quiz list
  // * and then filters the data on the client
  // * Todo: Replace this with server side search
  Future<List<Quiz>> search(String query) async {
    // 1. Get all Quizs from Firestore
    final quizsList = await futureQuizsList();
    // 2. Perform client-side filtering
    return quizsList
        .where((quiz) => quiz.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

// this is Riverpod provider, named: quizRepositoryProvider
// just create instance of QuizRepository class
// this instance perform CRUD operation on firestore
@Riverpod(keepAlive: true)
QuizRepository quizRepository(QuizRepositoryRef ref) {
  return QuizRepository(FirebaseFirestore.instance);
}

// this is Riverpod provider, named: streamQuizsListProvider
// this provider will get list of stream data from quizRepository function
// this provider will send list of stream data to screen/page
@riverpod
Stream<List<Quiz>> streamQuizsList(StreamQuizsListRef ref) {
  final quizRepository = ref.watch(quizRepositoryProvider);
  return quizRepository.streamQuizsList();
}

// this is Riverpod provider, named: futureQuizsListProvider
// this provider will get list of future data from quizRepository function
// this provider will send list of future data to screen/page
@riverpod
Future<List<Quiz>> futureQuizsList(FutureQuizsListRef ref) {
  final quizRepository = ref.watch(quizRepositoryProvider);
  return quizRepository.futureQuizsList();
}

// this is Riverpod provider, named: streamQuizProvider
// this provider will get list of stream data from quizRepository function
// this provider will send list of stream data to screen/page
@riverpod
Stream<Quiz?> streamQuiz(StreamQuizRef ref, QuizID id) {
  final quizRepository = ref.watch(quizRepositoryProvider);
  return quizRepository.streamQuiz(id);
}

// this is Riverpod provider, named: futureQuizProvider
// this provider will get single future data from quizRepository function
// this provider will send single future data to screen/page
@riverpod
Future<Quiz?> futureQuiz(FutureQuizRef ref, QuizID id) {
  final quizRepository = ref.watch(quizRepositoryProvider);
  return quizRepository.futureQuiz(id);
}
