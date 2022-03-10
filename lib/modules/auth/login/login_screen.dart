import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/admin_app/admin_home_layout.dart';
import 'package:food_donation/layout/user_app/user_home_layout.dart';
import 'package:food_donation/modules/auth/login/cubit/login_cubit.dart';
import 'package:food_donation/modules/auth/login/cubit/login_cubit_states.dart';
import 'package:food_donation/modules/auth/signup/signup_screen.dart';
import 'package:food_donation/shared/components/components.dart';
import 'package:food_donation/shared/components/constants.dart';
import 'package:food_donation/shared/network/local/cache_helper.dart';
import 'package:food_donation/shared/style/color.dart';
import 'package:food_donation/shared/style/widgets.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginAppCubit(),
      child: BlocConsumer<LoginAppCubit, LoginAppStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error.toString()),
              duration: Duration(seconds: 4),
              backgroundColor: Colors.green,
            ));
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: "uId",
              value: state.uId,
            ).then((value) {
              uId = state.uId;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Thanks for Login"),
                duration: Duration(seconds: 4),
                backgroundColor: Colors.green,
              ));
              if(LoginAppCubit.get(context).emailController.text == 'admin@admin.com'){
                navigateAndFinish(context, AdminHomeLayout());
              }else{
                navigateAndFinish(context, UserHomeLayout());
              }
             // navigateAndFinish(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: height(context) - 100,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCustom(
                          text: "Login",
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        textFormBox(
                            textInputType: TextInputType.emailAddress,
                            nameController: LoginAppCubit.get(context).emailController,
                            labelText: "Email Address",
                            hintText: "Email Address",
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Must write your email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                        textFormBox(
                          textInputType: TextInputType.visiblePassword,
                          nameController: LoginAppCubit.get(context).passwordController,
                          labelText: "Password",
                          hintText: "************",
                          iconOn: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Must write your password';
                            }
                            return null;
                          },
                          icon: LoginAppCubit.get(context).suffix,
                          isObscureText: LoginAppCubit.get(context).isPassword,
                          iconPress: () {
                            LoginAppCubit.get(context).togglePassword();
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            textCustom(
                              text: "Forgot your password?",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            svg(svgImage: "assets/svg/arrow.svg", width: 25)
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Center(
                            child: Container(
                              width: 250,
                              child: defaultButton(
                                text: "Login",
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    LoginAppCubit.get(context)
                                        .loginUser(context: context);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textCustom(
                              text: "I don’t have",
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            GestureDetector(
                                onTap: () {
                                  navigateTo(context, SignUpScreen());
                                },
                                child: textCustom(
                                  text: "Account",
                                  textColor: primaryColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
