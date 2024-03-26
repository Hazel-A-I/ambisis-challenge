import 'package:flutter/material.dart';

class SigningPage extends StatelessWidget {
  const SigningPage({super.key});

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
                Icons.account_circle,
                size: 100,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Bem vindo! Crie suas credenciais aqui!",
                style: TextStyle(color: Colors.grey[700]),
              ),
              // photo
              // display name
              // email
              // password
              // re-enter password
              // button_primary "Criar conta"
              // mockup contato p/ suporte
            ],
          ),
        ),
      ),
    );
  }
}
