abstract class HomeLayoutStates {}

class HomeLayoutAppInitialState extends HomeLayoutStates {}

class BottomNavState extends HomeLayoutStates {}

class LoadingState extends HomeLayoutStates {}

class GetUserSuccessState extends HomeLayoutStates {}

class UploadFamilyInfoReloadState extends HomeLayoutStates {}

class UploadFamilyInfoSuccessState extends HomeLayoutStates {}

class GetFamilyInfoSuccessState extends HomeLayoutStates {}

class GetUserErrorState extends HomeLayoutStates {
  String error;

  GetUserErrorState(this.error);
}

class UploadFamilyInfoErrorState extends HomeLayoutStates {
  String error;

  UploadFamilyInfoErrorState(this.error);
}

class GetFamilyInfoErrorState extends HomeLayoutStates {
  String error;

  GetFamilyInfoErrorState(this.error);
}
