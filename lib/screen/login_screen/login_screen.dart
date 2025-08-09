import 'package:agrigrow/utility/extensions.dart';

import '../../utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // savedEmail: 'testing@gmail.com',
      // savedPassword: '12345',
      loginAfterSignUp: false,
      logo: const AssetImage('assets/images/logo.png'),
      // ignore: body_might_complete_normally_nullable
      onLogin: (loginData) async {
        final result = await context.userProvider.login(loginData);
        return result; // Will return null on success or error message on failure
      },
      // ignore: body_might_complete_normally_nullable
      onSignup: (data) async {
        final result = await context.userProvider.register(data);
        return result; // Will return null on success or error message on failure
      },
      onSubmitAnimationCompleted: () {
        if (context.userProvider.getLoginUsr()?.sId != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
        }
      },
      onRecoverPassword: (_) => null,
      hideForgotPasswordButton: true,
      theme: LoginTheme(
          primaryColor: AppColor.darkGrey,
          accentColor: AppColor.darkGreen,
          buttonTheme: const LoginButtonTheme(
            backgroundColor: AppColor.darkGreen,
          ),
          cardTheme: const CardTheme(
              color: Colors.white, surfaceTintColor: Colors.white),
          titleStyle: const TextStyle(color: Colors.black)),
    );
  }
}
