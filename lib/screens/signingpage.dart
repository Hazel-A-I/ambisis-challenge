import 'package:ambisis_challenge/components/button_primary.dart';
import 'package:ambisis_challenge/components/form_field.dart';
import 'package:ambisis_challenge/services/auth/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SigningPage extends StatelessWidget {
  final TextEditingController displayName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  SigningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    bool isValidEmail(String email) {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Bem vindo! Crie suas credenciais preenchendo os espaços!",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(
                  height: 25,
                ),

                CustomFormField(
                    controller: displayName,
                    labelText: "Nome de usuário",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  controller: email,
                  labelText: "E-mail",
                  obscureText: false,
                  validator: (input) =>
                      isValidEmail(input ?? "") ? null : "Check your email",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormField(
                    controller: password,
                    labelText: "Senha",
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                CustomFormField(
                    controller: confirmPassword,
                    labelText: "Confirme sua senha",
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonPrimary(
                  text: "Finalizar cadastro",
                  onTap: () async {
                    try {
                      if (password.text.trim().isEmpty) {
                        throw "A senha é obrigatória";
                      }

                      if (password.text != confirmPassword.text) {
                        throw "As senhas não coincidem";
                      }

                      await UserRepository.createUser(
                          displayName.text, email.text, password.text);

                      scaffoldMessenger.showSnackBar(const SnackBar(
                          content: Text(
                        "Criado com sucesso!",
                        style: TextStyle(color: Colors.white),
                      )));
                      // ignore: use_build_context_synchronously
                      context.go("/login");
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            e.toString(),
                            style: const TextStyle(color: Colors.white),
                          )));
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      const Divider(),
                      GestureDetector(
                        child: const Text(
                          'Já tem uma conta criada? Entre já!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onTap: () => context.go('/login'),
                      ),
                      const Divider(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
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
      ),
    );
  }
}
