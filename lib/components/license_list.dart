import 'package:ambisis_challenge/bloc/cubits/company_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/license_cubit.dart';
import 'package:ambisis_challenge/bloc/cubits/license_states.dart';
import 'package:ambisis_challenge/components/confirm_box.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LicenseListTab extends StatelessWidget {
  final String companyId;
  const LicenseListTab({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final companyCubit = context.read<CompanyCubit>();
    final licenseCubit = context.read<LicenseCubit>();
    return BlocBuilder<LicenseCubit, LicenseState>(
      builder: (context, state) {
        if (state is LoadingLicenseState) {
          return const SizedBox(
            height: 500,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LicenseLoadedState && state.licenses.isEmpty) {
          return const Center(
              child: Text('Nenhuma licença foi adicionada ainda.'));
        } else if (state is ErrorLicenseState) {
          return Center(
            child: Text("Ocorreu um problema: ${state.errorMessage}"),
          );
        } else {
          if (state is InitialLicenseState) {
            licenseCubit.fetchCompanyLicenses(companyId);
            return const Center(
                child: Text('Nenhuma licença foi adicionada ainda.'));
          } else if (state is LicenseLoadedState) {
            return _buildLicenseList(
                state.licenses, licenseCubit, companyCubit);
          } else {
            return const Center(
              child: Text("Não foi possível filtrar licenças."),
            );
          }
        }
      },
    );
  }

  Widget _buildLicenseList(List<LicenseModel> licenses,
      LicenseCubit licenseCubit, CompanyCubit companyCubit) {
    return ListView.builder(
      itemCount: licenses.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                final selectedLicense = licenses[index];
                context.push('/license-details', extra: selectedLicense);
              },
              title: Text(
                licenses[index].environmentalAgency,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        final company =
                            await companyCubit.getCompanyById(companyId);

                        context.push('/license-signing',
                            extra: LicenseArguments(
                                isEditing: true,
                                currentLicense: licenses[index],
                                currentCompany: company));
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
            ),
            const Divider()
          ],
        );
      },
    );
  }
}
