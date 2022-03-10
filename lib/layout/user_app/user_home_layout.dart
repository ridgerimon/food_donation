import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/user_app/cubit/cubit.dart';
import 'package:food_donation/layout/user_app/cubit/states.dart';
import 'package:food_donation/shared/components/constants.dart';
import 'package:food_donation/shared/style/color.dart';

import '../../shared/style/widgets.dart';

class UserHomeLayout extends StatelessWidget {
  final familyNameController = TextEditingController();
  final familyNumberController = TextEditingController();
  final familyAddressController = TextEditingController();
  final familyStatesController = TextEditingController();
  final familyMembersController = TextEditingController();
  final familyNeedsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutAppCubit, HomeLayoutStates>(
      listener: (context, states) {
        if (states is UploadFamilyInfoReloadState) {
          circularProgress();
        }
        if (states is UploadFamilyInfoSuccessState) {
          Navigator.pop(context);
        }
        if (states is UploadFamilyInfoErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(states.error.toString()),
            duration: const Duration(seconds: 4),
            backgroundColor: primaryColor,
          ));
        }
      },
      builder: (context, states) {
        var cubit = HomeLayoutAppCubit.get(context);
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => customDialog(context));
            },
            backgroundColor: primaryColor,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget customDialog(context) => Dialog(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Family Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                textFormBox(
                  textInputType: TextInputType.text,
                  nameController: familyNameController,
                  labelText: "Family Name",
                  hintText: "Family Name",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Must write family name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                textFormBox(
                  textInputType: TextInputType.number,
                  nameController: familyNumberController,
                  labelText: "Family Number",
                  hintText: "Family Number",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Must write family number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                textFormBox(
                  textInputType: TextInputType.text,
                  nameController: familyAddressController,
                  labelText: "Family Address",
                  hintText: "Family Address",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Must write family address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                textFormBox(
                  textInputType: TextInputType.text,
                  nameController: familyStatesController,
                  labelText: "Family State",
                  hintText: "Family State",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Must write family state';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                textFormBox(
                  textInputType: TextInputType.text,
                  nameController: familyMembersController,
                  labelText: "Family Members",
                  hintText: "Family Members",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Must write family members';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                textFormBox(
                  textInputType: TextInputType.text,
                  nameController: familyNeedsController,
                  labelText: "Family Needs",
                  hintText: "Family Needs",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Must write family Needs';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    defaultButton(
                      function: () {
                        HomeLayoutAppCubit.get(context).uploadFamilyData(
                          familyName: familyNameController.text,
                          familyAddress: familyAddressController.text,
                          familyMembers: familyMembersController.text,
                          familyNumber: familyNumberController.text,
                          familyState: familyStatesController.text,
                          familyWant: familyNeedsController.text,
                          context: context,
                        );
                      },
                      text: 'Add',
                    ),
                    Spacer(),
                    defaultButton(
                      function: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
