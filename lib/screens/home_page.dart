import 'dart:async';

import 'package:ambisis_challenge/bloc/cubits/auth_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/auth_states.dart';
import 'package:ambisis_challenge/bloc/cubits/company_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/company_states.dart';
import 'package:ambisis_challenge/components/confirm_box.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/screens/company_details.dart';
import 'package:ambisis_challenge/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Home: lista contendo todas as empresas e um botão para criar uma nova empresa no topo da página;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final companyCubit = context.read<CompanyCubit>();

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
                child: BlocBuilder<CompanyCubit, CompanyState>(
                  builder: (context, state) {
                    if (state is CompanyLoadedState) {
                      if (state.companies.isEmpty) {
                        return const Text(
                            'Nenhuma empresa foi adicionada ainda.');
                      }
                      return _buildCompanyList(state.companies, companyCubit);
                    } else if (state is LoadingCompanyState) {
                      return const CircularProgressIndicator();
                    } else if (state is InitialCompanyState) {
                      companyCubit.fetchCompanies();
                      return const Text(
                          'Nenhuma empresa foi adicionada ainda.');
                    } else {
                      companyCubit.fetchCompanies();
                      return const Center(
                        child: Text('Não foi possível filtrar empresas.'),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        } else if (state is LoadingUserState) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          return LoginPage();
        }
      },
    );
  }

  Widget _buildCompanyList(
      List<CompanyModel> companies, CompanyCubit companyCubit) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            final selectedUser = companies[index];
            context.go('/company-details', extra: selectedUser);
          },
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    context.go('/company-signing', extra: true);
                  },
                  icon: const Icon(Icons.edit)),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () => showConfirmDialog(context,
                    () => companyCubit.deleteCompany(companies[index])),
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                ),
                color: Colors.red,
              ),
            ],
          ),
          title: Text(companies[index].legalName),
          subtitle: Text("Adc em: ${companies[index].addedAt}"),
        );
      },
    );
  }
}
