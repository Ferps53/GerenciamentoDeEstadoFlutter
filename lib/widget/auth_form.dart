// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

enum AuthMode { SingUp, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 320,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return "Informe um email válido";
                  }
                  ;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                onSaved: (password) => _authData['password'] = password ?? '',
                obscureText: true,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return "Informe uma senha válida";
                  }
                  return null;
                },
              ),
              if (_authMode == AuthMode.SingUp)
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: _authMode == AuthMode.Login
                        ? null
                        : (_password) {
                            final password = _password ?? '';
                            if (password != _passwordController.text) {
                              return "Senhas não conferem!";
                            }
                            return null;
                          }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
