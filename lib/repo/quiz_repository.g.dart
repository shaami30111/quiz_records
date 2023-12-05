// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizRepositoryHash() => r'56bf8267646ae2147ef840a5725d18d512ef11e2';

/// See also [quizRepository].
@ProviderFor(quizRepository)
final quizRepositoryProvider = Provider<QuizRepository>.internal(
  quizRepository,
  name: r'quizRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuizRepositoryRef = ProviderRef<QuizRepository>;
String _$streamQuizsListHash() => r'f3da491e9053ec69fa841f64444b4d11ce1ee95f';

/// See also [streamQuizsList].
@ProviderFor(streamQuizsList)
final streamQuizsListProvider = AutoDisposeStreamProvider<List<Quiz>>.internal(
  streamQuizsList,
  name: r'streamQuizsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$streamQuizsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StreamQuizsListRef = AutoDisposeStreamProviderRef<List<Quiz>>;
String _$futureQuizsListHash() => r'af97e39c9f51f2dac0ac11b5ca03c0dc8d659bdd';

/// See also [futureQuizsList].
@ProviderFor(futureQuizsList)
final futureQuizsListProvider = AutoDisposeFutureProvider<List<Quiz>>.internal(
  futureQuizsList,
  name: r'futureQuizsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureQuizsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureQuizsListRef = AutoDisposeFutureProviderRef<List<Quiz>>;
String _$streamQuizHash() => r'3372222d7f783196f4bfeecb117e2519165524ce';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [streamQuiz].
@ProviderFor(streamQuiz)
const streamQuizProvider = StreamQuizFamily();

/// See also [streamQuiz].
class StreamQuizFamily extends Family<AsyncValue<Quiz?>> {
  /// See also [streamQuiz].
  const StreamQuizFamily();

  /// See also [streamQuiz].
  StreamQuizProvider call(
    String id,
  ) {
    return StreamQuizProvider(
      id,
    );
  }

  @override
  StreamQuizProvider getProviderOverride(
    covariant StreamQuizProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'streamQuizProvider';
}

/// See also [streamQuiz].
class StreamQuizProvider extends AutoDisposeStreamProvider<Quiz?> {
  /// See also [streamQuiz].
  StreamQuizProvider(
    String id,
  ) : this._internal(
          (ref) => streamQuiz(
            ref as StreamQuizRef,
            id,
          ),
          from: streamQuizProvider,
          name: r'streamQuizProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamQuizHash,
          dependencies: StreamQuizFamily._dependencies,
          allTransitiveDependencies:
              StreamQuizFamily._allTransitiveDependencies,
          id: id,
        );

  StreamQuizProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Quiz?> Function(StreamQuizRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamQuizProvider._internal(
        (ref) => create(ref as StreamQuizRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Quiz?> createElement() {
    return _StreamQuizProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamQuizProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamQuizRef on AutoDisposeStreamProviderRef<Quiz?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _StreamQuizProviderElement extends AutoDisposeStreamProviderElement<Quiz?>
    with StreamQuizRef {
  _StreamQuizProviderElement(super.provider);

  @override
  String get id => (origin as StreamQuizProvider).id;
}

String _$futureQuizHash() => r'8d36d4940f71a95a1505b371c13efcbac8e615b4';

/// See also [futureQuiz].
@ProviderFor(futureQuiz)
const futureQuizProvider = FutureQuizFamily();

/// See also [futureQuiz].
class FutureQuizFamily extends Family<AsyncValue<Quiz?>> {
  /// See also [futureQuiz].
  const FutureQuizFamily();

  /// See also [futureQuiz].
  FutureQuizProvider call(
    String id,
  ) {
    return FutureQuizProvider(
      id,
    );
  }

  @override
  FutureQuizProvider getProviderOverride(
    covariant FutureQuizProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'futureQuizProvider';
}

/// See also [futureQuiz].
class FutureQuizProvider extends AutoDisposeFutureProvider<Quiz?> {
  /// See also [futureQuiz].
  FutureQuizProvider(
    String id,
  ) : this._internal(
          (ref) => futureQuiz(
            ref as FutureQuizRef,
            id,
          ),
          from: futureQuizProvider,
          name: r'futureQuizProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$futureQuizHash,
          dependencies: FutureQuizFamily._dependencies,
          allTransitiveDependencies:
              FutureQuizFamily._allTransitiveDependencies,
          id: id,
        );

  FutureQuizProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Quiz?> Function(FutureQuizRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FutureQuizProvider._internal(
        (ref) => create(ref as FutureQuizRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Quiz?> createElement() {
    return _FutureQuizProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FutureQuizProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FutureQuizRef on AutoDisposeFutureProviderRef<Quiz?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FutureQuizProviderElement extends AutoDisposeFutureProviderElement<Quiz?>
    with FutureQuizRef {
  _FutureQuizProviderElement(super.provider);

  @override
  String get id => (origin as FutureQuizProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
