import 'package:url_launcher/url_launcher.dart';


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
