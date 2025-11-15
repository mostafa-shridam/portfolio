import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/enum/constants.dart';
import '../core/models/project.dart';

part 'generated/projects.g.dart';

@riverpod
class Projects extends _$Projects {
  late FirebaseFirestore _firestore;
  @override
  ProjectsState build() {
    _firestore = FirebaseFirestore.instance;
    return ProjectsState();
  }

  Future<void> getProjectsByUserId(String? userId) async {
    state = state.copyWith(isLoading: true);
    try {
      if (userId == null) throw Exception('User not authenticated');
      if (!ref.mounted) return; // لو widget اتدمرت، سيب الموضوع

      final snap = await _firestore
          .collection(Constants.projectsBox.name)
          .doc(userId)
          .collection(Constants.projects.name)
          .get();
      final proects = List<Project>.from(
        snap.docs.map((doc) => Project.fromJson(doc.data())),
      );
      state = state.copyWith(projects: proects, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class ProjectsState {
  List<Project>? projects;
  bool? isLoading;

  ProjectsState({this.projects, this.isLoading});

  ProjectsState copyWith({
    List<Project>? projects,
    bool? isLoading,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
