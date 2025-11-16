import 'package:portfolio/providers/about.dart';
import 'package:portfolio/providers/courses.dart';
import 'package:portfolio/providers/projects.dart';
import 'package:portfolio/providers/skills.dart';
import 'package:portfolio/providers/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'generated/init.g.dart';

@Riverpod(keepAlive: true)
class Init extends _$Init {
  @override
  InitState build() {
    return InitState(isLoading: false, isError: false);
  }

  Future<void> initAllData(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(userDataProvider.notifier).getUserData(userId);
      if (!ref.mounted) return;

      await ref.read(aboutProviderProvider.notifier).fetchAllData(userId);
      if (!ref.mounted) return;

      await ref.read(coursesProvider.notifier).getCoursesByUserId(userId);
      if (!ref.mounted) return;

      await ref.read(projectsProvider.notifier).getProjectsByUserId(userId);
      if (!ref.mounted) return;

      await ref.read(skillsProvider.notifier).getSkillsByUserId(userId);
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, isError: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, isError: true);
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class InitState {
  bool? isLoading;
  bool? isError;
  String? errorMessage;
  InitState({this.isLoading, this.isError, this.errorMessage});

  InitState copyWith({bool? isLoading, bool? isError, String? errorMessage}) {
    return InitState(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
