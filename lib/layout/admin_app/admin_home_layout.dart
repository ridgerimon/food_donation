import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/admin_app/cubit/cubit.dart';
import 'package:food_donation/layout/admin_app/cubit/states.dart';
import 'package:food_donation/shared/style/color.dart';
import 'package:food_donation/shared/style/widgets.dart';

class AdminHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminHomeLayoutAppCubit, AdminHomeLayoutStates>(
      listener: (context, states) {
        if (states is AdminUploadFamilyInfoReloadState) {
          circularProgress();
        }
        if (states is AdminUploadFamilyInfoSuccessState) {
          Navigator.pop(context);
        }
        if (states is AdminUploadFamilyInfoErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(states.error.toString()),
            duration: const Duration(seconds: 4),
            backgroundColor: primaryColor,
          ));
        }
      },
      builder: (context, states) {
        var cubit = AdminHomeLayoutAppCubit.get(context);
        return Scaffold(
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: primaryColor,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.items,
          ),
        );
      },
    );
  }
}
