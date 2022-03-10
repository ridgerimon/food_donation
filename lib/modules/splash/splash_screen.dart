import 'package:flutter/material.dart';
import 'package:food_donation/modules/auth/login/login_screen.dart';
import 'package:food_donation/shared/components/components.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 3),
            () {
          navigateAndFinish(context,  LoginScreen());
        }
    );
    return Scaffold(
      body: Center(child: Image.asset("assets/images/logo_name.png")),
    );
  }
}
