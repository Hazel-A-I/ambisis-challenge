import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Bem vindo! Insira suas credenciais e conecte-se!",
                style: TextStyle(color: Colors.grey[700]),
              ),
              // login
              // password
              // button_primary "Entrar"
              // mockup contato p/ suporte
            ],
          ),
        ),
      ),
    );
  }
}
