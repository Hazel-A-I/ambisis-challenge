import 'package:ambisis_challenge/bloc/cubits/auth_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/auth_states.dart';
import 'package:ambisis_challenge/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Home: lista contendo todas as empresas e um botão para criar uma nova empresa no topo da página;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: const Text("Cadastro de empresas"),
              leading: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  userCubit.logout();
                  context.go('/login');
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => context.go('/company-signing'),
                ),
              ],
            ),
            body: SafeArea(
              child: Center(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, index) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text('a')],
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is LoadingUserState) {
          return const CircularProgressIndicator();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
