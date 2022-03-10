import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/admin_app/cubit/states.dart';
import 'package:food_donation/models/request_model.dart';
import 'package:food_donation/models/user_model.dart';
import 'package:food_donation/modules/admin_all_request/admin_all_request_screen.dart';
import 'package:food_donation/modules/admin_profile/admin_profile_screen.dart';
import 'package:food_donation/shared/components/constants.dart';

class AdminHomeLayoutAppCubit extends Cubit<AdminHomeLayoutStates> {
  AdminHomeLayoutAppCubit() : super(AdminHomeLayoutAppInitialState());

  static AdminHomeLayoutAppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.food_bank_sharp),
      label: 'All Request',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  List<Widget> Screens = [
    AdminAllRequestScreen(),
    AdminProfileScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AdminBottomNavState());
  }

  /*void getUserData() async {
    emit(AdminLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserModel.formJson(value.data());
      emit(AdminGetUserSuccessState());
    }).catchError((error) {
      emit(AdminGetUserErrorState(error.toString()));
    });
  }*/

  /*void uploadFamilyData({
    required String familyName,
    required String familyAddress,
    required String familyMembers,
    required String familyNumber,
    required String familyState,
    required String familyWant,
    required context,
  }) {
    emit(AdminUploadFamilyInfoReloadState());
    RequestModel requestModel = RequestModel(
      familyName: familyName,
      familyAddress: familyAddress,
      familyMembers: familyMembers,
      familyNumber: familyNumber,
      familyState: familyState,
      familyWant: familyWant,
      uid: uId!,
    );
    FirebaseFirestore.instance
        .collection("request")
        .add(requestModel.toJson())
        .then((value) {
      emit(AdminUploadFamilyInfoSuccessState());
    }).catchError((error) {
      emit(AdminUploadFamilyInfoErrorState(error));
    });
  }*/

  List<RequestModel> allRequest = [];

  void getRequestData() async {
    await FirebaseFirestore.instance.collection('request').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        allRequest.add(RequestModel.formJson(element.data()));
        emit(AdminGetFamilyInfoSuccessState());
      });
    }).catchError((error) {
      emit(AdminGetFamilyInfoErrorState(error.toString()));
    });
  }
}
