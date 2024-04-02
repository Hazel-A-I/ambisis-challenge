import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/models/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LicenseBar extends StatelessWidget {
  final CompanyModel company;
  const LicenseBar({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Licenças de: ${company.legalName}'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.push('/license-signing',
              extra:
                  LicenseArguments(isEditing: false, currentCompany: company)),
        ),
      ],
    );
  }
}
