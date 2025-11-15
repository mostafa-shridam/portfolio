import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/enum/constants.dart';
import '../core/models/skill.dart';

part 'generated/skills.g.dart';

@riverpod
class Skills extends _$Skills {
  late FirebaseFirestore _firestore;
  @override
  SkillsState build() {
    _firestore = FirebaseFirestore.instance;
    return SkillsState();
  }

  Future<void> getSkillsByUserId(String? userId) async {
    state = state.copyWith(isLoading: true);
    try {
      if (!ref.mounted) return; // لو widget اتدمرت، سيب الموضوع

      final snap = await _firestore.collection(Constants.skills.name).get();
      final skills = List<Skill>.from(
        snap.docs.map((doc) => Skill.fromJson(doc.data())),
      );
      state = state.copyWith(skills: skills, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

class SkillsState {
  bool? isLoading;
  List<Skill>? skills;

  SkillsState({
    this.isLoading,
    this.skills,
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
