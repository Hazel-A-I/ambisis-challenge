import 'package:ambisis_challenge/bloc/cubits/license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LicenseSignPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _licenseNumberController = TextEditingController();
  final _environmentalAgencyController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _expirationDateController = TextEditingController();
  LicenseSignPage({super.key, this.isEditing = false});
  final bool? isEditing;

  String textoEditar() {
    return isEditing ?? false ? "Editar " : '';
  }

  @override
  Widget build(BuildContext context) {
    final licenseCubit = context.read<LicenseCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de licença'),
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back)),
      ),
    );
  }
}
