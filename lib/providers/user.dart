import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/core/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/enum/constants.dart';

part 'generated/user.g.dart';

@riverpod
class UserData extends _$UserData {
  late FirebaseFirestore _firestore;
  @override
  UserState build() {
    _firestore = FirebaseFirestore.instance;
    return UserState();
  }

  Future<void> getUserData(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      if (!ref.mounted) return; // لو widget اتدمرت، سيب الموضوع

      final snap = await _firestore
          .collection(Constants.portfolioUser.name)
          .doc(userId)
          .get();
      final user = UserModel.fromJson(snap.data() ?? {});
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

class UserState {
  UserModel? user;
  bool? isLoading;

  UserState({this.user, this.isLoading});

  UserState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
