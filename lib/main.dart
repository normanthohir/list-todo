import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workshop_flutter_firebases/firebase_options.dart';
import 'package:workshop_flutter_firebases/pages/list_todo_page.dart';
import 'package:workshop_flutter_firebases/pages/authentication/login/login_page.dart';
import 'package:workshop_flutter_firebases/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
