import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/user_app/cubit/states.dart';
import 'package:food_donation/models/request_model.dart';
import 'package:food_donation/models/user_model.dart';
import 'package:food_donation/modules/all_donation_req/all_donation_req.dart';
import 'package:food_donation/modules/profile/profile_screen.dart';
import 'package:food_donation/modules/user_donation_req/donation_req_screen.dart';
import 'package:food_donation/shared/components/constants.dart';
import 'package:food_donation/shared/network/local/cache_helper.dart';
import 'package:food_donation/shared/style/color.dart';

class HomeLayoutAppCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutAppCubit() : super(HomeLayoutAppInitialState());

  static HomeLayoutAppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.request_page_outlined),
      label: 'My Request',
    ),
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
    DonationReqScreens(),
    AllDonationReqScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  void getUserData() async {
    emit(LoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserModel.formJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  void uploadFamilyData({
    required String familyName,
    required String familyAddress,
    required String familyMembers,
    required String familyNumber,
    required String familyState,
    required String familyWant,
    required context,
  }) {
    emit(UploadFamilyInfoReloadState());
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
      emit(UploadFamilyInfoSuccessState());
    }).catchError((error) {
      emit(UploadFamilyInfoErrorState(error));
    });
  }

  List<RequestModel> allRequest = [];
  List<RequestModel> myRequest = [];

  void getRequestData() async {
    await FirebaseFirestore.instance.collection('request').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        allRequest.add(RequestModel.formJson(element.data()));
        if (element.data()['uid'] == uId) {
          myRequest.add(
            RequestModel.formJson(
              element.data(),
            ),
          );
        }
        emit(GetFamilyInfoSuccessState());
      });
    }).catchError((error) {
      emit(GetFamilyInfoErrorState(error.toString()));
    });
  }
}
