import 'package:ambisis_challenge/models/license_model.dart';
import 'package:flutter/material.dart';

class LicenseDetailsPage extends StatelessWidget {
  final LicenseModel license;

  const LicenseDetailsPage({super.key, required this.license});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Licença Ambiental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Empresa:',
            ),
            Text(license.companyId),
            const SizedBox(height: 10),
            const Text(
              'Número:',
            ),
            Text(license.licenseNumber),
            const SizedBox(height: 10),
            const Text(
              'Órgão ambiental:',
            ),
            Text(license.environmentalAgency),
            const SizedBox(height: 10),
            const Text(
              'Emissão:',
            ),
            Text(license.formattedIssueDate),
            const SizedBox(height: 10),
            const Text(
              'Validade:',
            ),
            Text(license.formattedExpirationDate),
          ],
        ),
      ),
    );
  }
}
