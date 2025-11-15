// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../skills.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Skills)
const skillsProvider = SkillsProvider._();

final class SkillsProvider extends $NotifierProvider<Skills, SkillsState> {
  const SkillsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'skillsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$skillsHash();

  @$internal
  @override
  Skills create() => Skills();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SkillsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SkillsState>(value),
    );
  }
}

String _$skillsHash() => r'43289f6a5684d99035db05e8f31915f8b4e0f9d6';

abstract class _$Skills extends $Notifier<SkillsState> {
  SkillsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SkillsState, SkillsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SkillsState, SkillsState>, SkillsState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
