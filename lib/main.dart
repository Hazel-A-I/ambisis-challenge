import 'dart:async';

import 'package:ambisis_challenge/bloc/cubits/auth_cubit.dart';
import 'package:ambisis_challenge/screens/homepage.dart';
import 'package:ambisis_challenge/screens/loginpage.dart';
import 'package:ambisis_challenge/screens/signingpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/signing',
        builder: (context, state) => SigningPage(),
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
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
