import 'package:ambisis_challenge/components/license_bar.dart';
import 'package:ambisis_challenge/components/license_list.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CompanyDetailsPage extends StatelessWidget {
  final CompanyModel company;

  const CompanyDetailsPage({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Detalhes da empresa'),
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Empresa: ${company.legalName}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          LicenseBar(
            company: company,
          ),
          Expanded(child: LicenseListTab(companyId: company.id))
        ],
      ),
    );
  }
}
