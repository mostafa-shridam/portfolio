// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../courses.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Courses)
const coursesProvider = CoursesProvider._();

final class CoursesProvider extends $NotifierProvider<Courses, CoursesState> {
  const CoursesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'coursesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$coursesHash();

  @$internal
  @override
  Courses create() => Courses();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CoursesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CoursesState>(value),
    );
  }
}

String _$coursesHash() => r'085b2917e97aad85fefdc7c3a31047b44b3b045f';

abstract class _$Courses extends $Notifier<CoursesState> {
  CoursesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CoursesState, CoursesState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<CoursesState, CoursesState>,
        CoursesState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
