abstract class AdminHomeLayoutStates {}

class AdminHomeLayoutAppInitialState extends AdminHomeLayoutStates {}

class AdminBottomNavState extends AdminHomeLayoutStates {}

class AdminLoadingState extends AdminHomeLayoutStates {}

class AdminGetUserSuccessState extends AdminHomeLayoutStates {}

class AdminUploadFamilyInfoReloadState extends AdminHomeLayoutStates {}

class AdminUploadFamilyInfoSuccessState extends AdminHomeLayoutStates {}

class AdminGetFamilyInfoSuccessState extends AdminHomeLayoutStates {}

class AdminGetUserErrorState extends AdminHomeLayoutStates {
  String error;

  AdminGetUserErrorState(this.error);
}

class AdminUploadFamilyInfoErrorState extends AdminHomeLayoutStates {
  String error;

  AdminUploadFamilyInfoErrorState(this.error);
}

class AdminGetFamilyInfoErrorState extends AdminHomeLayoutStates {
  String error;

  AdminGetFamilyInfoErrorState(this.error);
}
