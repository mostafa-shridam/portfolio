// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../projects.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Projects)
const projectsProvider = ProjectsProvider._();

final class ProjectsProvider
    extends $NotifierProvider<Projects, ProjectsState> {
  const ProjectsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'projectsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$projectsHash();

  @$internal
  @override
  Projects create() => Projects();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectsState>(value),
    );
  }
}

String _$projectsHash() => r'479bf41067f669baaf9026ab5d472007f77e090c';

abstract class _$Projects extends $Notifier<ProjectsState> {
  ProjectsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProjectsState, ProjectsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ProjectsState, ProjectsState>,
        ProjectsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
