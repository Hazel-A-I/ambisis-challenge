import 'package:ambisis_challenge/screens/homepage.dart';
import 'package:ambisis_challenge/screens/loginpage.dart';
import 'package:ambisis_challenge/screens/signingpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signing',
        builder: (context, state) => const SigningPage(),
      ),
      GoRoute(
        path: '/company-signing',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/license-signing',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      routerConfig: _router,
    );
  }
}
