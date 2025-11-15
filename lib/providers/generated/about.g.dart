// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../about.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AboutProvider)
const aboutProviderProvider = AboutProviderProvider._();

final class AboutProviderProvider
    extends $NotifierProvider<AboutProvider, AboutState> {
  const AboutProviderProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'aboutProviderProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$aboutProviderHash();

  @$internal
  @override
  AboutProvider create() => AboutProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AboutState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AboutState>(value),
    );
  }
}

String _$aboutProviderHash() => r'ec5e309f432fc35faa562ff6c4cad297d13a9fa8';

abstract class _$AboutProvider extends $Notifier<AboutState> {
  AboutState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AboutState, AboutState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AboutState, AboutState>, AboutState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
