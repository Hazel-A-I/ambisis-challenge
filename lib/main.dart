import 'dart:async';

import 'package:ambisis_challenge/bloc/cubits/auth_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/company_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/license_cubit.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/route_arguments.dart';
import 'package:ambisis_challenge/screens/company_details.dart';
import 'package:ambisis_challenge/screens/company_signing.dart';
import 'package:ambisis_challenge/screens/home_page.dart';
import 'package:ambisis_challenge/screens/license_details.dart';
import 'package:ambisis_challenge/screens/license_signing.dart';
import 'package:ambisis_challenge/screens/login_page.dart';
import 'package:ambisis_challenge/screens/signing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        builder: (context, state) => CompanySigningPage(
          routeArguments: RouteArguments(
              isEditing: (state.extra as RouteArguments).isEditing,
              currentCompany: (state.extra as RouteArguments).currentCompany),
        ),
      ),
      GoRoute(
        path: '/license-signing',
        builder: (context, state) => LicenseSignPage(
          licenseArguments: LicenseArguments(
              isEditing: (state.extra as LicenseArguments).isEditing,
              currentLicense: (state.extra as LicenseArguments).currentLicense,
              currentCompany: (state.extra as LicenseArguments).currentCompany),
        ),
      ),
      GoRoute(
          path: '/company-details',
          builder: (context, state) =>
              CompanyDetailsPage(company: state.extra as CompanyModel)),
      GoRoute(
          path: '/license-details',
          builder: (context, state) =>
              LicenseDetailsPage(license: state.extra as LicenseModel)),
    ],
  );
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<CompanyCubit>(
            create: (context) => CompanyCubit(firestoreInstance: firestore)),
        BlocProvider(
            create: (context) => LicenseCubit(firestoreInstance: firestore))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
