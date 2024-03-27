import 'package:ambisis_challenge/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Home: lista contendo todas as empresas e um botão para criar uma nova empresa no topo da página;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              context.go('/login');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/company-signing'),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, index) {
            return const Row(
              children: [Text('a')],
            );
          },
        ),
      ),
    );
  }
}
