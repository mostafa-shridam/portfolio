// import 'package:flutter/material.dart';
// import '../../pages/home/home.dart';
// import '../../pages/project_details/project_details.dart';
// import '../models/project.dart';

// Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
//   switch (settings.name) {
//     case HomePage.routeName:
//       return MaterialPageRoute(builder: (context) => const HomePage());
//     case ProjectDetails.routeName:
//       return MaterialPageRoute(
//         builder: (context) {
//           final args = settings.arguments as Map<String, dynamic>?;
//           final project = args?['project'] as Project?;
//           final selectedColor = args?['selectedColor'] as int?;
//           return ProjectDetails(project: project, selectedColor: selectedColor);
//         },
//       );

//     default:
//       return null;
//   }
// };
