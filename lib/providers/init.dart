import 'package:portfolio/providers/about.dart';
import 'package:portfolio/providers/courses.dart';
import 'package:portfolio/providers/projects.dart';
import 'package:portfolio/providers/skills.dart';
import 'package:portfolio/providers/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'generated/init.g.dart';

@riverpod
class Init extends _$Init {
  @override
  InitState build() {
    return InitState(isLoading: false, isError: false);
  }

  Future<void> initAllData(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      if (!ref.mounted) return;

      final userFuture =
          ref.read(userDataProvider.notifier).getUserData(userId);
      final aboutFuture =
          ref.read(aboutProviderProvider.notifier).fetchAllData(userId);
      final coursesFuture =
          ref.read(coursesProvider.notifier).getCoursesByUserId(userId);
      final projectsFuture =
          ref.read(projectsProvider.notifier).getProjectsByUserId(userId);
      final skillsFuture =
          ref.read(skillsProvider.notifier).getSkillsByUserId(userId);

      // انتظر كل الفيوتشرز واحدة واحدة وتحقق من mounted بعد كل واحدة
      await userFuture;
      if (!ref.mounted) return;

      await aboutFuture;
      if (!ref.mounted) return;

      await coursesFuture;
      if (!ref.mounted) return;

      await projectsFuture;
      if (!ref.mounted) return;

      await skillsFuture;
      if (!ref.mounted) return;
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
