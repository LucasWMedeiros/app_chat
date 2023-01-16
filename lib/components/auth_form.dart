import 'dart:io';

import 'package:app_chat/components/user_image_picker.dart';
import 'package:app_chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthFormData();

  void _handleImagePick(File image) {
    _authData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (_authData.image == null && _authData.isSignup) {
      return _showError('Imagem não Selecionada');
    }

    widget.onSubmit(_authData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_authData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authData.name,
                  onChanged: (name) => _authData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 3) {
                      return 'Nome deve ter no minimo 3 caracteres';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'E-mail informado não é valido';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _authData.password,
                onChanged: (password) => _authData.password = password,
                key: const ValueKey('password'),
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.trim().length < 6) {
                    return 'Senha informada é curta demais! No minimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authData.toggleAuthMode();
                  });
                },
                child: Text(
                  _authData.isLogin
                      ? 'Criar uma nova conta'
                      : 'Já possuo uma conta',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
