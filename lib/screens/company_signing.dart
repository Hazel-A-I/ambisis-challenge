import 'package:ambisis_challenge/bloc/cubits/company_cubit.dart';
import 'package:ambisis_challenge/components/button_primary.dart';
import 'package:ambisis_challenge/components/confirm_box.dart';
import 'package:ambisis_challenge/components/form_field.dart';
import 'package:ambisis_challenge/models/address.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:ambisis_challenge/models/license_model.dart';
import 'package:ambisis_challenge/models/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// For sync between edit mode and sign mode. Need to make error handling for when the user passes incorrect values to the routing.

class CompanySigningPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _legalNameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _complementController = TextEditingController();

  CompanySigningPage({super.key, required this.routeArguments});
  final RouteArguments routeArguments;
  String textEdit() {
    return routeArguments.isEditing ? "Editar " : '';
  }

  void editingInputsFill() {
    if (routeArguments.isEditing && routeArguments.currentCompany != null) {
      _legalNameController.text = routeArguments.currentCompany!.legalName;
      _cnpjController.text = routeArguments.currentCompany!.cnpj;
      _postalCodeController.text =
          routeArguments.currentCompany!.address.postalCode;
      _cityController.text = routeArguments.currentCompany!.address.city;
      _stateController.text = routeArguments.currentCompany!.address.state;
      _neighborhoodController.text =
          routeArguments.currentCompany!.address.neighborhood;
      _complementController.text =
          routeArguments.currentCompany!.address.complement;
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyCubit = context.read<CompanyCubit>();
    editingInputsFill();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Cadastro de empresa'),
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                controller: _legalNameController,
                labelText: '${textEdit()}Razão social - Nome legal',
                obscureText: false,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Razão social/Nome legal é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _cnpjController,
                labelText: '${textEdit()}CNPJ',
                obscureText: false,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'O CNPJ é obrigatório'
                    : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text('Endereço'),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _postalCodeController,
                labelText: '${textEdit()}Código postal / CEP',
                obscureText: false,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Código postal é obrigatório'
                    : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _cityController,
                labelText: '${textEdit()}Cidade',
                obscureText: false,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Cidade é obrigatória'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _stateController,
                labelText: '${textEdit()}Estado',
                obscureText: false,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Estado é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _neighborhoodController,
                labelText: '${textEdit()}Bairro',
                obscureText: false,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Bairro é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _complementController,
                labelText: 'Complemento',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
                    ? 'Complemento é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              ButtonPrimary(
                text: "Enviar",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final company = CompanyModel(
                      id: (routeArguments.isEditing &&
                              routeArguments.currentCompany != null)
                          ? routeArguments.currentCompany!.id
                          : DateTime.now().millisecondsSinceEpoch.toString(),
                      legalName: _legalNameController.text,
                      cnpj: _cnpjController.text,
                      address: Address(
                        postalCode: _postalCodeController.text,
                        city: _cityController.text,
                        state: _stateController.text,
                        neighborhood: _neighborhoodController.text,
                        complement: _complementController.text,
                      ),
                    );
                    routeArguments.isEditing
                        ? companyCubit.updateCompany(company)
                        : companyCubit.createCompany(company);
                    context.go("/");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
