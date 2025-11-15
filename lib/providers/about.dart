import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/enum/constants.dart';
import '../../../../core/local_service/save_user.dart';
import '../../../../core/models/about.dart';
import '../../../../core/models/education.dart';
import '../../../../core/models/experience.dart';

part 'generated/about.g.dart';

@riverpod
class AboutProvider extends _$AboutProvider {
  late FirebaseFirestore _firestore;
  late SaveUser _saveUser;

  @override
  AboutState build() {
    _firestore = FirebaseFirestore.instance;
    _saveUser = SaveUser.instance;

    // Load data from local storage first
    final localAbout = _saveUser.getAboutData();
    final localWorkExperience = _saveUser.getWorkExperience();
    final localEducation = _saveUser.getEducation();

    // Fetch fresh data from Firebase in the background

    return AboutState(
      about: localAbout,
      workExperience: localWorkExperience,
      education: localEducation,
      isLoading: false,
    );
  }

  // ============================================
  // ABOUT DATA METHODS
  // ============================================

  Future<void> getAboutData(String userId) async {
    try {
      final aboutData = await _firestore
          .collection(Constants.aboutData.name)
          .doc(userId)
          .get();

      if (aboutData.exists && aboutData.data() != null) {
        final about = AboutModel.fromJson(aboutData.data()!);
        await _saveUser.saveAboutData(jsonEncode(about.toJson()));

        state = state.copyWith(
          about: about,
          isLoading: false,
          clearError: true,
        );

        if (kDebugMode) {
          log('About data retrieved and saved to local storage');
        }
      } else {
        state = state.copyWith(isLoading: false, clearError: true);
        if (kDebugMode) {
          log('No about data found in Firebase');
        }
      }
    } catch (e) {
      _handleError('Error getting about data', e);
    }
  }

  // ============================================
  // WORK EXPERIENCE METHODS
  // ============================================
  Future<void> _getWorkExperience(String userId) async {
    try {
      final workExperience = await _firestore
          .collection(Constants.workExperience.name)
          .doc(userId)
          .collection(Constants.workExperience.name)
          .get();

      if (workExperience.docs.isNotEmpty) {
        final workExperienceData = workExperience.docs
            .map((e) => Experience.fromJson(e.data()))
            .toList();

        final sortedList = _sortExperienceByDate(workExperienceData);

        await _saveUser.saveWorkExperience(
          jsonEncode(sortedList.map((e) => e.toJson()).toList()),
        );

        state = state.copyWith(
          workExperience: sortedList,
          isLoading: false,
          clearError: true,
        );

        if (kDebugMode) {
          log('Work experience retrieved: ${sortedList.length} items');
        }
      } else {
        state = state.copyWith(isLoading: false, clearError: true);
        if (kDebugMode) {
          log('No work experience found in Firebase');
        }
      }
    } catch (e) {
      _handleError('Error getting work experience', e);
    }
  }

  // ============================================
  // EDUCATION METHODS
  // ============================================
  Future<void> _getEducation(String userId) async {
    try {
      final educationData = await _firestore
          .collection(Constants.education.name)
          .doc(userId)
          .collection(Constants.education.name)
          .get();

      if (educationData.docs.isNotEmpty) {
        final educationList = educationData.docs
            .map((e) => Education.fromJson(e.data()))
            .toList();

        final sortedList = _sortEducationByDate(educationList);

        await _saveUser.saveEducation(
          jsonEncode(sortedList.map((e) => e.toJson()).toList()),
        );

        state = state.copyWith(
          education: sortedList,
          isLoading: false,
          clearError: true,
        );

        if (kDebugMode) {
          log('Education retrieved: ${sortedList.length} items');
        }
      } else {
        state = state.copyWith(isLoading: false, clearError: true);
        if (kDebugMode) {
          log('No education found in Firebase');
        }
      }
    } catch (e) {
      _handleError('Error getting education', e);
    }
  }

  // ============================================
  // UTILITY METHODS
  // ============================================

  Future<void> fetchAllData(String userId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      if (!ref.mounted) return; // لو widget اتدمرت، سيب الموضوع

      await Future.wait([
        getAboutData(userId),
        _getWorkExperience(userId),
        _getEducation(userId),
      ]);

      state = state.copyWith(isLoading: false, clearError: true);

      if (kDebugMode) {
        log('All data refreshed successfully');
      }
    } catch (e) {
      _handleError('Error refreshing all data', e);
    }
  }

  void loadLocalData() {
    final localAbout = _saveUser.getAboutData();
    final localWorkExperience = _saveUser.getWorkExperience();
    final localEducation = _saveUser.getEducation();

    state = state.copyWith(
      about: localAbout,
      workExperience: localWorkExperience,
      education: localEducation,
      isLoading: false,
      clearError: true,
    );

    if (kDebugMode) {
      log(
        'Local data loaded - About: ${localAbout != null}, '
        'Work: ${localWorkExperience?.length ?? 0}, '
        'Education: ${localEducation?.length ?? 0}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  // ============================================
  // PRIVATE HELPER METHODS
  // ============================================

  void _handleError(String message, Object error) {
    state = state.copyWith(isLoading: false, error: error.toString());
    if (kDebugMode) {
      log('$message: $error');
    }
  }

  List<Experience> _sortExperienceByDate(List<Experience> experiences) {
    final sorted = [...experiences];
    sorted.sort((a, b) {
      // Current positions first
      if (a.isCurrent == true && b.isCurrent != true) return -1;
      if (b.isCurrent == true && a.isCurrent != true) return 1;

      // Then sort by start date (most recent first)
      if (a.startDate != null && b.startDate != null) {
        return b.startDate!.compareTo(a.startDate!);
      }
      return 0;
    });
    return sorted;
  }

  List<Education> _sortEducationByDate(List<Education> educationList) {
    final sorted = [...educationList];
    sorted.sort((a, b) {
      // Current education first
      if (a.startDate != null && b.startDate == null) return -1;
      if (b.startDate != null && a.startDate == null) return 1;

      // Then sort by start date (most recent first)
      if (a.startDate != null && b.startDate != null) {
        return b.startDate!.compareTo(a.startDate!);
      }
      return 0;
    });
    return sorted;
  }
}

// ============================================
// STATE CLASS
// ============================================

class AboutState {
  final AboutModel? about;
  final List<Experience>? workExperience;
  final List<Education>? education;
  final bool isLoading;
  final String? error;

  const AboutState({
    this.about,
    this.workExperience,
    this.education,
    this.isLoading = false,
    this.error,
  });

  AboutState copyWith({
    AboutModel? about,
    List<Experience>? workExperience,
    List<Education>? education,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return AboutState(
      about: about ?? this.about,
      workExperience: workExperience ?? this.workExperience,
      education: education ?? this.education,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  bool get hasData =>
      about != null ||
      (workExperience != null && workExperience!.isNotEmpty) ||
      (education != null && education!.isNotEmpty);

  bool get hasError => error != null;

  @override
  String toString() {
    return 'AboutState(about: $about, '
        'workExperience: ${workExperience?.length}, '
        'education: ${education?.length}, '
        'isLoading: $isLoading, '
        'error: $error)';
  }
}
