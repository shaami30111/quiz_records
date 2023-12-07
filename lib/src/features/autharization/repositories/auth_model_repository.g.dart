// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'4b0d6bb2e2502fa8297ff1aa5dc61a7a6e31aa14';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$streamAuthModelsListHash() =>
    r'09e5bdd6e9524cd9a21c314879ce335b5e3bf042';

/// See also [streamAuthModelsList].
@ProviderFor(streamAuthModelsList)
final streamAuthModelsListProvider =
    AutoDisposeStreamProvider<List<AuthModel>>.internal(
  streamAuthModelsList,
  name: r'streamAuthModelsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$streamAuthModelsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StreamAuthModelsListRef = AutoDisposeStreamProviderRef<List<AuthModel>>;
String _$futureAuthModelsListHash() =>
    r'72daea176e8e3884618f5862b9ee97e8e7ea8a84';

/// See also [futureAuthModelsList].
@ProviderFor(futureAuthModelsList)
final futureAuthModelsListProvider =
    AutoDisposeFutureProvider<List<AuthModel>>.internal(
  futureAuthModelsList,
  name: r'futureAuthModelsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureAuthModelsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureAuthModelsListRef = AutoDisposeFutureProviderRef<List<AuthModel>>;
String _$streamAuthModelHash() => r'fde818eb9a578632fe9d5876ff2b82b3ce04e093';

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

/// See also [streamAuthModel].
@ProviderFor(streamAuthModel)
const streamAuthModelProvider = StreamAuthModelFamily();

/// See also [streamAuthModel].
class StreamAuthModelFamily extends Family<AsyncValue<AuthModel?>> {
  /// See also [streamAuthModel].
  const StreamAuthModelFamily();

  /// See also [streamAuthModel].
  StreamAuthModelProvider call(
    String userId,
  ) {
    return StreamAuthModelProvider(
      userId,
    );
  }

  @override
  StreamAuthModelProvider getProviderOverride(
    covariant StreamAuthModelProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'streamAuthModelProvider';
}

/// See also [streamAuthModel].
class StreamAuthModelProvider extends AutoDisposeStreamProvider<AuthModel?> {
  /// See also [streamAuthModel].
  StreamAuthModelProvider(
    String userId,
  ) : this._internal(
          (ref) => streamAuthModel(
            ref as StreamAuthModelRef,
            userId,
          ),
          from: streamAuthModelProvider,
          name: r'streamAuthModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamAuthModelHash,
          dependencies: StreamAuthModelFamily._dependencies,
          allTransitiveDependencies:
              StreamAuthModelFamily._allTransitiveDependencies,
          userId: userId,
        );

  StreamAuthModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<AuthModel?> Function(StreamAuthModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamAuthModelProvider._internal(
        (ref) => create(ref as StreamAuthModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AuthModel?> createElement() {
    return _StreamAuthModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamAuthModelProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamAuthModelRef on AutoDisposeStreamProviderRef<AuthModel?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _StreamAuthModelProviderElement
    extends AutoDisposeStreamProviderElement<AuthModel?>
    with StreamAuthModelRef {
  _StreamAuthModelProviderElement(super.provider);

  @override
  String get userId => (origin as StreamAuthModelProvider).userId;
}

String _$futureAuthModelHash() => r'0676b5393e1b2018b13523cd8dc765e30c9b0682';

/// See also [futureAuthModel].
@ProviderFor(futureAuthModel)
const futureAuthModelProvider = FutureAuthModelFamily();

/// See also [futureAuthModel].
class FutureAuthModelFamily extends Family<AsyncValue<AuthModel?>> {
  /// See also [futureAuthModel].
  const FutureAuthModelFamily();

  /// See also [futureAuthModel].
  FutureAuthModelProvider call(
    String userId,
  ) {
    return FutureAuthModelProvider(
      userId,
    );
  }

  @override
  FutureAuthModelProvider getProviderOverride(
    covariant FutureAuthModelProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'futureAuthModelProvider';
}

/// See also [futureAuthModel].
class FutureAuthModelProvider extends AutoDisposeFutureProvider<AuthModel?> {
  /// See also [futureAuthModel].
  FutureAuthModelProvider(
    String userId,
  ) : this._internal(
          (ref) => futureAuthModel(
            ref as FutureAuthModelRef,
            userId,
          ),
          from: futureAuthModelProvider,
          name: r'futureAuthModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$futureAuthModelHash,
          dependencies: FutureAuthModelFamily._dependencies,
          allTransitiveDependencies:
              FutureAuthModelFamily._allTransitiveDependencies,
          userId: userId,
        );

  FutureAuthModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<AuthModel?> Function(FutureAuthModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FutureAuthModelProvider._internal(
        (ref) => create(ref as FutureAuthModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AuthModel?> createElement() {
    return _FutureAuthModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FutureAuthModelProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FutureAuthModelRef on AutoDisposeFutureProviderRef<AuthModel?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FutureAuthModelProviderElement
    extends AutoDisposeFutureProviderElement<AuthModel?>
    with FutureAuthModelRef {
  _FutureAuthModelProviderElement(super.provider);

  @override
  String get userId => (origin as FutureAuthModelProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
