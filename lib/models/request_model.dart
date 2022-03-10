class RequestModel {
  late String familyName;
  late String familyNumber;
  late String familyAddress;
  late String familyState;
  late String familyMembers;
  late String familyWant;
  late String uid;

  RequestModel({
    required this.familyName,
    required this.familyNumber,
    required this.familyAddress,
    required this.familyState,
    required this.familyMembers,
    required this.familyWant,
    required this.uid,
  });

  RequestModel.formJson(Map <String, dynamic>? json) {
    if (json == null) {
      return;
    }
    familyName = json['familyName'];
    familyNumber = json['familyNumber'];
    familyAddress = json['familyAddress'];
    familyState = json['familyState'];
    familyMembers = json['familyMembers'];
    familyWant = json['familyWant'];
    uid = json['uid'];
  }
  Map<String, dynamic> toJson() {
    return {
      'familyName': familyName,
      'familyNumber': familyNumber,
      'familyAddress': familyAddress,
      'familyState': familyState,
      'familyMembers': familyMembers,
      'familyWant': familyWant,
      'uid': uid,
    };
  }
}
