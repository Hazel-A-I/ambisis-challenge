import 'package:ambisis_challenge/bloc/cubits/license_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/license_states.dart';
import 'package:ambisis_challenge/components/confirm_box.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/screens/license_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompanyDetailsPage extends StatelessWidget {
  final CompanyModel company;

  const CompanyDetailsPage({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final licenseCubit = context.read<LicenseCubit>();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Detalhes da empresa'),
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Empresa: ${company.legalName}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text('CNPJ: ${company.cnpj}'),
            const SizedBox(height: 10.0),
            const Text('Endereço:'),
            const SizedBox(height: 5.0),
            Text('  - CEP: ${company.address.postalCode}'),
            Text('  - Cidade: ${company.address.city}'),
            Text('  - Estado: ${company.address.state}'),
            Text('  - Bairro: ${company.address.neighborhood}'),
            Text('  - Complemento: ${company.address.complement}'),
            const SizedBox(height: 10.0),
            // BlocBuilder(
            //   builder: (context, state) {
            //     if (state is LoadingLicenseState) {
            //       return const SizedBox(
            //         height: 500,
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     } else if (state is LicenseLoadedState) {
            //       return _buildLicenseList(state.licenses, licenseCubit);
            //     } else if (state is ErrorLicenseState) {
            //       return Center(
            //         child: Text("Ocorreu um problema: ${state.errorMessage}"),
            //       );
            //     } else {
            //       if ((state is LicenseLoadedState && state.licenses.isEmpty) ||
            //           state is InitialLicenseState) {
            //         return const Center(
            //           child: Text("Não há licenças cadastradas nesta empresa."),
            //         );
            //       }
            //       return const Center(
            //           child: Text("Ocorreu um problema desconhecido!"));
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseList(
      List<LicenseModel> licenses, LicenseCubit licenseCubit) {
    return ListView.builder(
      itemCount: licenses.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(
                licenses[index].environmentalAgency,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        context.go('/license-signing', extra: true);
                      },
                      icon: const Icon(Icons.edit)),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () => showConfirmDialog(context,
                        () => licenseCubit.removeLicense(licenses[index])),
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                    ),
                    color: Colors.red,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LicenseDetailsPage(license: licenses[index]),
                  ),
                );
              },
            ),
            const Divider()
          ],
        );
      },
    );
  }
}
