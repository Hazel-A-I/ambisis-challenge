import 'package:ambisis_challenge/bloc/cubits/company_cubit.dart';
import 'package:ambisis_challenge/components/button_primary.dart';
import 'package:ambisis_challenge/components/confirm_box.dart';
import 'package:ambisis_challenge/components/form_field.dart';
import 'package:ambisis_challenge/models/address.dart';
import 'package:ambisis_challenge/models/company_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompanySigningPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _legalNameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _complementController = TextEditingController();

  CompanySigningPage({super.key, this.isEditing = false});
  final bool? isEditing;
  String textoEditar() {
    return isEditing ?? false ? "Editar " : '';
  }

  @override
  Widget build(BuildContext context) {
    final companyCubit = context.read<CompanyCubit>();
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
                labelText: '${textoEditar()}Razão social - Nome legal',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
                    ? 'Razão social/Nome legal é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _cnpjController,
                labelText: '${textoEditar()}CNPJ',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
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
                labelText: '${textoEditar()}Código postal / CEP',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
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
                labelText: '${textoEditar()}Cidade',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
                    ? 'Cidade é obrigatória'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _stateController,
                labelText: '${textoEditar()}Estado',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
                    ? 'Estado é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20.0),
              CustomFormField(
                controller: _neighborhoodController,
                labelText: '${textoEditar()}Bairro',
                obscureText: false,
                validator: (value) => value == null || value.isEmpty
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
                      id: (isEditing ?? false
                          ? null
                          : DateTime.now().millisecondsSinceEpoch.toString()),
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
                    isEditing ?? false
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
