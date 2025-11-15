import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/enum/constants.dart';
import '../core/models/course.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/courses.g.dart';

@riverpod
class Courses extends _$Courses {
  late FirebaseFirestore _firestore;
  @override
  CoursesState build() {
    _firestore = FirebaseFirestore.instance;
    return CoursesState();
  }

  Future<void> getCoursesByUserId(String? userId) async {
    state = state.copyWith(isLoading: true);
    try {
      if (userId == null) throw Exception('User not authenticated');
      if (!ref.mounted) return; // لو widget اتدمرت، سيب الموضوع

      final snap = await _firestore
          .collection(Constants.coursesBox.name)
          .doc(userId)
          .collection(Constants.courses.name)
          .get();
      final courses = List<Course>.from(
        snap.docs.map((doc) => Course.fromJson(doc.data())),
      );
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
