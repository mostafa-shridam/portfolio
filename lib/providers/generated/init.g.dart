// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../init.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Init)
const initProvider = InitProvider._();

final class InitProvider extends $NotifierProvider<Init, InitState> {
  const InitProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'initProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$initHash();

  @$internal
  @override
  Init create() => Init();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InitState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InitState>(value),
    );
  }
}

String _$initHash() => r'16d493d7644d57ce533cd4aaba02e93370e820d7';

abstract class _$Init extends $Notifier<InitState> {
  InitState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<InitState, InitState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<InitState, InitState>, InitState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
