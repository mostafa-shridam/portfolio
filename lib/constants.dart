import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/assets.dart';
import 'pages/home/models/projects.dart';

const String myName = 'Mostafa Abdulrhman';
const String myEmail = 'mostafashridam@gmail.com';
const String myPhone = '+201017216494';
const String myFacebook = 'https://www.facebook.com/Mostafashridam.mostafa';
const String myLocation = 'Sharqia, Egypt';
const String myLinkedin =
    'https://www.linkedin.com/in/mostafa-abdulrhman-b744ab22a/';
const String myGithub = 'https://github.com/mostafa-shridam';
const String rifqanAppRepo = 'https://github.com/mostafa-shridam/RIfqan';
const String shopAppRepo = 'https://github.com/mostafa-shridam/souqApp';
const String filmyAppRepo = 'https://github.com/mostafa-shridam/filmy';
Future<void> customLaunchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

final projects = [
  Project(
    title: 'Rifqan',
    description:
        'A beautiful Flutter app with amazing features, built with Flutter, Dart, Firebase, UI/UX, Figma, Flutter Hive, Flutter Local Notifications',
    image: Assets.assetsRifqan,
    tags: {
      'Flutter': Colors.blue,
      'Dart': Colors.cyan,
      'Firebase': Colors.orange,
      'Flutter Riverpod': Colors.red,
      'Flutter OneSignal': Colors.lightGreen,
      'Flutter Supabase': Colors.brown,
      'UI/UX': Colors.purple,
      'Figma': Colors.pink,
      'Flutter Hive': Colors.green,
      'Flutter Local Notifications': Colors.indigo,
    },
    images: [Assets.assetsNotification],
  ),
  Project(
    title: 'Shop App',
    description:
        'A beautiful Flutter app with amazing features, built with Flutter, Dart, Firebase, UI/UX, Figma, Flutter Bloc, Shared Preferences',
    image: Assets.assetsSouqApp,
    tags: {
      'Flutter': Colors.blue,
      'Dart': Colors.cyan,
      'Firebase': Colors.orange,
      'Supabase': Colors.brown,
      'UI/UX': Colors.purple,
      'Figma': Colors.pink,
      'Shared Preferences': Colors.green,
      'Flutter Bloc': Colors.indigo,
    },
    images: [Assets.assetsSouqApp],
  ),
  Project(
    title: 'Filmy App',
    description:
        'A beautiful Flutter app with amazing features, built with Flutter, Dart, UI/UX, Flutter Riverpod, Rest API',
    image: Assets.assetsFilmy,
    tags: {
      'Flutter': Colors.blue,
      'Dart': Colors.cyan,
      'UI/UX': Colors.purple,
      'Flutter Riverpod': Colors.red,
      'Rest API': Colors.green,
    },
    images: [Assets.assetsFilmy],
  ),
];
