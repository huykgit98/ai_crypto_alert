// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeRepositoryHash() => r'1f00a561f0adfba4136250c33546d952be88423b';

/// See also [themeRepository].
@ProviderFor(themeRepository)
final themeRepositoryProvider = AutoDisposeProvider<ThemeRepository>.internal(
  themeRepository,
  name: r'themeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeRepositoryRef = AutoDisposeProviderRef<ThemeRepository>;
String _$getThemeHash() => r'd000b046deb8454d08292e1cc4555c5abc5ceddf';

/// See also [getTheme].
@ProviderFor(getTheme)
final getThemeProvider = AutoDisposeFutureProvider<int?>.internal(
  getTheme,
  name: r'getThemeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetThemeRef = AutoDisposeFutureProviderRef<int?>;
String _$setThemeHash() => r'2f17c78f29e50135b479f7a9df20bd5b536fc328';

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

/// See also [setTheme].
@ProviderFor(setTheme)
const setThemeProvider = SetThemeFamily();

/// See also [setTheme].
class SetThemeFamily extends Family<AsyncValue<bool>> {
  /// See also [setTheme].
  const SetThemeFamily();

  /// See also [setTheme].
  SetThemeProvider call({
    required int theme,
  }) {
    return SetThemeProvider(
      theme: theme,
    );
  }

  @override
  SetThemeProvider getProviderOverride(
    covariant SetThemeProvider provider,
  ) {
    return call(
      theme: provider.theme,
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
  String? get name => r'setThemeProvider';
}

/// See also [setTheme].
class SetThemeProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [setTheme].
  SetThemeProvider({
    required int theme,
  }) : this._internal(
          (ref) => setTheme(
            ref as SetThemeRef,
            theme: theme,
          ),
          from: setThemeProvider,
          name: r'setThemeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setThemeHash,
          dependencies: SetThemeFamily._dependencies,
          allTransitiveDependencies: SetThemeFamily._allTransitiveDependencies,
          theme: theme,
        );

  SetThemeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.theme,
  }) : super.internal();

  final int theme;

  @override
  Override overrideWith(
    FutureOr<bool> Function(SetThemeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetThemeProvider._internal(
        (ref) => create(ref as SetThemeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        theme: theme,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SetThemeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetThemeProvider && other.theme == theme;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, theme.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetThemeRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `theme` of this provider.
  int get theme;
}

class _SetThemeProviderElement extends AutoDisposeFutureProviderElement<bool>
    with SetThemeRef {
  _SetThemeProviderElement(super.provider);

  @override
  int get theme => (origin as SetThemeProvider).theme;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
