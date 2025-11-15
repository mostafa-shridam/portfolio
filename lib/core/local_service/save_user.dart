import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../enum/constants.dart';
import '../models/about.dart';
import '../models/course.dart';
import '../models/education.dart';
import '../models/experience.dart';
import '../models/portfolio_model.dart';
import '../models/skill.dart';
import '../models/user_model.dart';
import '../theme/style.dart';
import 'local_storage.dart';

part 'generated/save_user.g.dart';

class SaveUser {
  static final SaveUser _instance = SaveUser._internal();
  SaveUser._internal();
  static SaveUser get instance => _instance;
  final LocalStorage _localStorage = LocalStorage.instance;

  // user data in local storage
  Future<void> saveUserData(String user) async {
    await _localStorage.saveData(key: Constants.userData.name, value: user);
  }

  UserModel? getUserData() {
    final String? user = _localStorage.getData(key: Constants.userData.name);
    if (user == null) {
      return null;
    }
    final userData = UserModel.fromJson(jsonDecode(user));
    selectedColor = userData.selectedColor ?? primaryColor.toARGB32();
    return userData;
  }

  // update user data in local storage
  Future<UserModel?> updateUserData(UserModel newUser) async {
    await _localStorage.saveData(
      key: Constants.userData.name,
      value: jsonEncode(newUser),
    );
    return newUser;
  }

  // delete user data in local storage
  Future<void> deleteUserData() async {
    await _localStorage.deleteData(key: Constants.userData.name);
    await _localStorage.deleteData(key: Constants.userPortfolioData.name);
    await _localStorage.deleteData(key: Constants.loginKey.name);
    await _localStorage.deleteData(key: Constants.aboutData.name);
    await _localStorage.deleteData(key: Constants.workExperience.name);
    await _localStorage.deleteData(key: Constants.education.name);
    await _localStorage.deleteData(key: Constants.portfolioUser.name);
    await _localStorage.deleteData(key: Constants.themeKey.name);
    await _localStorage.deleteData(key: Constants.languageKey.name);
    await _localStorage.deleteData(key: Constants.fontSize.name);
    await _localStorage.deleteData(key: Constants.fontFamily.name);
    await _localStorage.deleteData(key: Constants.notificationSettings.name);
    await _localStorage.deleteData(key: Constants.accessibilitySettings.name);
    await _localStorage.deleteData(key: Constants.privacySettings.name);
    await _localStorage.deleteData(key: Constants.displaySettings.name);
  }

  // portfolio data in local storage
  Future<void> savePortfolioData(String user) async {
    await _localStorage.saveData(
      key: Constants.userPortfolioData.name,
      value: user,
    );
  }

  PortfolioModel? getPortfolioData() {
    final String? user = _localStorage.getData(
      key: Constants.userPortfolioData.name,
    );
    if (user == null) {
      return null;
    }
    return PortfolioModel.fromJson(jsonDecode(user));
  }

  // about data in local storage
  Future<void> saveAboutData(String about) async {
    await _localStorage.saveData(key: Constants.aboutData.name, value: about);
  }

  AboutModel? getAboutData() {
    final String? about = _localStorage.getData(key: Constants.aboutData.name);
    if (about == null) {
      return null;
    }
    return AboutModel.fromJson(jsonDecode(about));
  }

  Future<void> saveWorkExperience(String workExperience) async {
    await _localStorage.saveData(
      key: Constants.workExperience.name,
      value: workExperience,
    );
  }

  List<Experience>? getWorkExperience() {
    final String? workExperience = _localStorage.getData(
      key: Constants.workExperience.name,
    );
    if (workExperience == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(workExperience);

      // Handle both single object and list cases
      if (decoded is List) {
        return decoded.map((e) => Experience.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        // Single experience object
        return [Experience.fromJson(decoded)];
      } else {
        return [];
      }
    } catch (e) {
      // Return empty list if parsing fails
      return [];
    }
  }

  Future<void> saveEducation(String education) async {
    await _localStorage.saveData(
      key: Constants.education.name,
      value: education,
    );
  }

  List<Education>? getEducation() {
    final String? education = _localStorage.getData(
      key: Constants.education.name,
    );
    if (education == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(education);

      // Handle both single object and list cases
      if (decoded is List) {
        return decoded.map((e) => Education.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        // Single education object
        return [Education.fromJson(decoded)];
      } else {
        return [];
      }
    } catch (e) {
      // Return empty list if parsing fails
      return [];
    }
  }

  Future<void> saveSkills(String skills) async {
    await _localStorage.saveData(key: Constants.skills.name, value: skills);
  }

  List<Skill>? getSkills() {
    final String? skills = _localStorage.getData(key: Constants.skills.name);
    if (skills == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(skills);

      // Handle both single object and list cases
      if (decoded is List) {
        return decoded.map((e) => Skill.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        // Single education object
        return [Skill.fromJson(decoded)];
      } else {
        return [];
      }
    } catch (e) {
      // Return empty list if parsing fails
      return [];
    }
  }

  Future<void> saveCourses(String courses) async {
    await _localStorage.saveData(key: Constants.courses.name, value: courses);
  }

  List<Course>? getCourses() {
    final String? courses = _localStorage.getData(key: Constants.courses.name);
    if (courses == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(courses);

      // Handle both single object and list cases
      if (decoded is List) {
        return decoded.map((e) => Course.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        // Single course object
        return [Course.fromJson(decoded)];
      } else {
        return [];
      }
    } catch (e) {
      // Return empty list if parsing fails
      return [];
    }
  }
}

@riverpod
SaveUser saveUser(Ref ref) => SaveUser.instance;
