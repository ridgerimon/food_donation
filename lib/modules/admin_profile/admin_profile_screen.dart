import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation/modules/auth/login/login_screen.dart';
import 'package:food_donation/shared/components/components.dart';
import 'package:food_donation/shared/network/local/cache_helper.dart';
import 'package:food_donation/shared/style/widgets.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 300.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo_name.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColorDark,
                      backgroundImage:
                          AssetImage('assets/images/logo_name.png')),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "Admin",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(35)),
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Email Address: Admin@admin.com",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              width: 250,
              height: 50,
              child: defaultButton(
                text: "Logout",
                function: () {
                  CacheHelper.remove(key: "uId");
                  FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Logout"),
                    duration: Duration(seconds: 4),
                    backgroundColor: Colors.green,
                  ));
                  navigateAndFinish(context, LoginScreen());
                },
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    ));
  }
}
