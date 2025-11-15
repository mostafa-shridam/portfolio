// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserData)
const userDataProvider = UserDataProvider._();

final class UserDataProvider extends $NotifierProvider<UserData, UserState> {
  const UserDataProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userDataProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userDataHash();

  @$internal
  @override
  UserData create() => UserData();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserState>(value),
    );
  }
}

String _$userDataHash() => r'48debfd996bea07fcd28273850f5f20e1d0de6a1';

abstract class _$UserData extends $Notifier<UserState> {
  UserState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserState, UserState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UserState, UserState>, UserState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
