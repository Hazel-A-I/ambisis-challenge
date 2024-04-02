import 'package:ambisis_challenge/bloc/cubits/license_cubit.dart';
import 'package:ambisis_challenge/components/button_primary.dart';
import 'package:ambisis_challenge/components/form_field.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LicenseSignPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _licenseNumberController = TextEditingController();
  final _environmentalAgencyController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _expirationDateController = TextEditingController();
  LicenseSignPage({super.key, required this.licenseArguments});
  final LicenseArguments licenseArguments;

  String textEdit() {
    return licenseArguments.isEditing ? "Editar " : '';
  }

  void editingInputsFill() {
    if (licenseArguments.isEditing && licenseArguments.currentLicense != null) {
      _licenseNumberController.text =
          licenseArguments.currentLicense!.licenseNumber;
      _environmentalAgencyController.text =
          licenseArguments.currentLicense!.environmentalAgency;
      _issueDateController.text =
          licenseArguments.currentLicense!.formattedIssueDate;
      _expirationDateController.text =
          licenseArguments.currentLicense!.formattedExpirationDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(TextEditingController controller) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      if (picked != null) {
        controller.text = picked.toString();
      }
    }

    final licenseCubit = context.read<LicenseCubit>();
    editingInputsFill();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Cadastro de licença'),
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                controller: _licenseNumberController,
                labelText: '${textEdit()}Número da licença',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
                    ? 'Número da licença é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _environmentalAgencyController,
                labelText: '${textEdit()}Órgão ambiental',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
                    ? 'Órgão ambiental é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _issueDateController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Data de emissão"),
                readOnly: true,
                onTap: () => selectDate(_issueDateController),
              ),
              TextFormField(
                controller: _expirationDateController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Data de validade"),
                readOnly: true,
                onTap: () => selectDate(_expirationDateController),
              ),
              const SizedBox(height: 20.0),
              ButtonPrimary(
                text: "Enviar",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final license = LicenseModel(
                        id: (licenseArguments.isEditing)
                            ? licenseArguments.currentLicense!.id
                            : DateTime.now().millisecondsSinceEpoch.toString(),
                        companyId: licenseArguments.currentCompany.id,
                        licenseNumber: _licenseNumberController.text,
                        environmentalAgency:
                            _environmentalAgencyController.text,
                        issueDate: DateTime.parse(_issueDateController.text),
                        expirationDate:
                            DateTime.parse(_expirationDateController.text));
                    licenseArguments.isEditing
                        ? licenseCubit.editLicense(license)
                        : licenseCubit.addLicense(license);
                    context.pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
