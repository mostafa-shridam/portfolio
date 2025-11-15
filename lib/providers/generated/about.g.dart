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

String _$aboutProviderHash() => r'1075fac4ff45b93413d329f18aa0e12f563f1ad9';

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
