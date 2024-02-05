import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media/auth/auth.dart';
import 'package:social_media/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
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
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
            color: Colors.grey[900],
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            iconTheme: const IconThemeData(color: Colors.white)),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(background: Colors.grey[300]),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
