import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/enum/constants.dart';
import '../core/models/skill.dart';

part 'generated/skills.g.dart';

@Riverpod(keepAlive: true)
class Skills extends _$Skills {
  late FirebaseFirestore _firestore;

  @override
  SkillsState build() {
    _firestore = FirebaseFirestore.instance;
    return SkillsState(
      isLoading: false,
      skills: [],
    );
  }

  Future<void> getSkillsByUserId(String? userId) async {
    // 1) غيّر state قبل الـ await بشكل آمن
    state = state.copyWith(isLoading: true);

    try {
      // 2) الـ await هنا
      final snap = await _firestore
          .collection(Constants.skills.name)
          .doc(userId)
          .collection(Constants.skills.name)
          .get();

      // 3) check بعد الـ await
      if (!ref.mounted) return;

      final skills =
          snap.docs.map((doc) => Skill.fromJson(doc.data())).toList();

      // 4) عدّل الـ state
      state = state.copyWith(
        skills: skills,
        isLoading: false,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }
}

class SkillsState {
  final bool isLoading;
  final List<Skill> skills;

  SkillsState({
    this.isLoading = false,
    this.skills = const [],
  });

  SkillsState copyWith({
    bool? isLoading,
    List<Skill>? skills,
  }) {
    return SkillsState(
      isLoading: isLoading ?? this.isLoading,
      skills: skills ?? this.skills,
    );
  }
}
