import 'dart:async';

import 'package:ambisis_challenge/bloc/cubits/auth_cubit.dart';
import 'package:ambisis_challenge/components/button_primary.dart';
import 'package:ambisis_challenge/components/button_secondary.dart';
import 'package:ambisis_challenge/components/form_field.dart';
import 'package:ambisis_challenge/models/user_model.dart';
import 'package:ambisis_challenge/services/auth/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formLogin = GlobalKey<FormState>();

  LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    Future<void> loginMethod() async {
      try {
        if (formLogin.currentState!.validate()) {
          await userCubit.login(emailController.text, passwordController.text);

          if (userCubit.user != null) {
            scaffoldMessenger.showSnackBar(SnackBar(
                content: Text(
              'Logando como: ${userCubit.user!.nick}',
              style: const TextStyle(color: Colors.white),
            )));
            // ignore: use_build_context_synchronously
            context.go('/');
          }
        }
      } on FirebaseException {
        print("firebase exceção");
        scaffoldMessenger.showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'O Email ou Senha informados estão inválidos.',
              style: TextStyle(color: Colors.white),
            )));
      } catch (e) {
        print(" exceção");
        scaffoldMessenger.showSnackBar(SnackBar(
            backgroundColor: Colors.red[300],
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            )));
      }
    }

    Future<void> resetPassword() async {
      final email = emailController.text.trim();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (await UserRepository.getUserByAuth(email) == null) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              content:
                  Text('Não foi encontrado nenhum usuário com este e-mail.'),
            ),
          );
        } else {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content:
                  Text('Foi enviado um e-mail de reset de senha para $email'),
            ),
          );
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'auth/user-not-found') {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              content:
                  Text('Não foi encontrado nenhum usuário com este e-mail.'),
            ),
          );
        } else {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Ocorreu um erro ao tentar resetar a senha.'),
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Icon(
                  Icons.lock,
                  color: Colors.black,
                  size: 100,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Bem vindo! Insira suas credenciais e conecte-se!",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Form(
                  key: formLogin,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Para iniciar, informe seu e-mail",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormField(
                        controller: emailController,
                        labelText: "E-mail",
                        obscureText: false,
                        validator: (value) {
                          if ((value ?? "").trim().isEmpty) {
                            return "Campo obrigatório";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomFormField(
                        controller: passwordController,
                        labelText: "Senha",
                        obscureText: true,
                        validator: (value) {
                          if ((value ?? "").trim().isEmpty) {
                            return "Campo obrigatório";
                          }
                          if ((value ?? "").trim().length < 6) {
                            return "A senha deve conter mais de 6 caracteres.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonPrimary(
                                  text: "Entrar",
                                  onTap: (() => loginMethod()),
                                ),
                                ButtonSecondary(
                                  text: 'Cadastrar-se',
                                  onTap: () => context.go('/signing'),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            GestureDetector(
                              onTap: () async {
                                await resetPassword();
                              },
                              child: const Text(
                                'Esqueceu sua senha? (preencha o e-mail.)',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
