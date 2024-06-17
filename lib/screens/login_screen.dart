import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si2_parcialito2/api/auth_api.dart';

const users = {
  'mario@gmail.com': '1234',
  'hunter@gmail.com': 'hunter',
};

class LoginScreenPage extends StatefulWidget {
  LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  bool _isLogin = false;
  String _message = '';
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        final response = await AuthApi().login(data.name, data.password);
        if (response.statusCode == 202) {
          _isLogin = true;
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', response.data.token);
          prefs.setInt('id', response.data.user.id);
          return null;
        } else {
          return 'Usuario o contraseña incorrectos';
        }
      } catch (e) {
        return e.toString();
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'null';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'ECORP',
        logo: const AssetImage('lib/assets/Logo.png'),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          if (_isLogin) {
            Navigator.pushNamed(context, '/menu');
          }
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
