class UserModel {
  late String userImage;
  late String userName;
  late String userEmail;
  late String userNumber;
  late String userID;

  UserModel({
    required this.userImage,
    required this.userName,
    required this.userEmail,
    required this.userNumber,
    required this.userID,
  });

  UserModel.formJson(Map <String, dynamic>? json) {
    if (json == null) {
      return;
    }
    userImage = json['userImage'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userNumber = json['userNumber'];
    userID = json['userID'];
  }
  Map<String, dynamic> toJson() {
    return {
      'userImage': userImage,
      'userName': userName,
      'userEmail': userEmail,
      'userNumber': userNumber,
      'userID': userID,
    };
  }
}
