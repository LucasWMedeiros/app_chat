import 'dart:io';
import 'dart:core' as core;

enum AuthMode {Signup, Login}

class AuthFormData {
  core.String name = '';
  core.String email = '';
  core.String password = '';
  File? image;
  AuthMode _mode = AuthMode.Login;

  core.bool get isLogin {
    return _mode == AuthMode.Login;
  }

  core.bool get isSignup {
    return _mode == AuthMode.Signup;
  }

  void toggleAuthMode(){
    _mode = isLogin ? AuthMode.Signup : AuthMode.Login;
  }
}