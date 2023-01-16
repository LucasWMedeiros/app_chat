import 'package:app_chat/components/auth_form.dart';
import 'package:app_chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) {
    setState(() =>_isLoading = true);
    print('AuthPage...');
    print(formData.email);
    
    setState(() =>_isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
         Center(
          child: SingleChildScrollView(
            child: AuthForm(onSubmit: _handleSubmit),
          ),
        ),
        if(_isLoading)
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.5)
          ),
          child: Center(child: CircularProgressIndicator()),
        )
        ]
      ),
    );
  }
}