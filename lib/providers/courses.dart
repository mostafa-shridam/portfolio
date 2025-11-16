import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/enum/constants.dart';
import '../core/models/course.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/courses.g.dart';

@Riverpod(keepAlive: true)
class Courses extends _$Courses {
  late FirebaseFirestore _firestore;
  @override
  CoursesState build() {
    _firestore = FirebaseFirestore.instance;
    return CoursesState();
  }

  Future<void> getCoursesByUserId(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final snap = await _firestore
          .collection(Constants.courses.name)
          .doc(userId)
          .collection(Constants.courses.name)
          .get();
      if (!ref.mounted) return;

      final courses =
          snap.docs.map((doc) => Course.fromJson(doc.data())).toList();
      state = state.copyWith(courses: courses, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class CoursesState {
  List<Course>? courses;
  bool? isLoading;

  CoursesState({
    this.courses,
    this.isLoading,
  });

  CoursesState copyWith({
    List<Course>? courses,
    bool? isLoading,
  }) {
    return CoursesState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
