import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/scroll_behavior.dart';
import 'core/theme.dart';
import 'pages/home/home.dart';
import 'providers/app_provider.dart';
import 'pages/project_details/project_details.dart';
import 'pages/home/models/projects.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable web-specific optimizations
  if (kIsWeb) {
    // Add any web-specific initialization here
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateLayout();
    });
  }

  void _updateLayout() {
    if (!mounted) return;
    final isMobile = MediaQuery.of(context).size.width < 600;
    ref.read(appProvider.notifier).updateLayout(isMobile);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appProvider.select((value) => value.themeMode));
    final isMobile = ref.watch(appProvider.select((value) => value.isMobile));

    return ResponsiveBreakpoints(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1200, name: DESKTOP),
        const Breakpoint(start: 1201, end: 1920, name: 'LARGE_DESKTOP'),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: MaterialApp(
        title: 'Mostafa Portfolio',
        debugShowCheckedModeBanner: false,
        theme: appTheme(isMobile),
        darkTheme: darkTheme(isMobile),
        themeMode: themeMode,
        home: const HomePage(),
        scrollBehavior: CustomScrollBehavior(),
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          return ResponsiveScaledBox(
            width: ResponsiveValue<double?>(
              context,
              conditionalValues: [
                const Condition.equals(name: MOBILE, value: 450),
                const Condition.between(start: 451, end: 800, value: 800),
                const Condition.between(start: 801, end: 1200, value: 1200),
                const Condition.between(start: 1201, end: 1920, value: 1920),
                Condition.largerThan(
                  name: 'LARGE_DESKTOP',
                  value: mediaQueryData.size.width < 1920
                      ? 1920.0
                      : mediaQueryData.size.width,
                ),
              ],
            ).value,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: child,
            ),
          );
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProjectDetails.routeName) {
            final project = settings.arguments as Project;
            return MaterialPageRoute(
              builder: (context) => ProjectDetails(project: project),
            );
          }
          return null;
        },
      ),
    );
  }
}
