import 'package:go_router/go_router.dart';
import 'package:portfolio/pages/home/home.dart';
import '../../pages/project_details/project_details.dart';
import '../models/project.dart';

/// Centralized GoRouter configuration for the entire app.
/// This replaces the old onGenerateRoute system and allows deep linking,
/// browser back/forward navigation on web, and easy route expansion.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: HomePage.routeName,

    routes: [
      GoRoute(
        path: '${HomePage.routeName}/:userId',
        name: HomePage.routeName,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return HomePage(userId: userId);
        },
      ),

      /// Project Details Page — supports arguments
      GoRoute(
        path: ProjectDetails.routeName,
        name: ProjectDetails.routeName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          final project = extra?['project'] as Project?;
          final selectedColor = extra?['selectedColor'] as int?;
          return ProjectDetails(project: project, selectedColor: selectedColor);
        },
      ),
    ],

    /// Debug log (optional)
    debugLogDiagnostics: true,
  );
}
