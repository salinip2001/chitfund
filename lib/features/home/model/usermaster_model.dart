class UserModelResponse {
  UserModelResponse({
    required this.data,
    required this.count,
  });

  List<UserModel> data;
  int count;

  factory UserModelResponse.from(Map<String, dynamic> json) =>
      UserModelResponse(
        data: List<UserModel>.from(
            json["data"].map((x) => UserModel.fromJson(x))),
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class UserModel {
  final int? userid;
  final String? username;
  final String? userfullname;
  final String? userpassword;
  final String? branchcode;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? phonenumber;

  UserModel(
      {this.userid,
      this.username,
      this.userfullname,
      this.userpassword,
      this.branchcode,
      this.address1,
      this.address2,
      this.address3,
      this.phonenumber});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userid: json['userid'],
        username: json['username'],
        userfullname: json['userfullname'],
        userpassword: json['userpassword'],
        branchcode: json['branchcode'],
        address1: json['address1'],
        address2: json['address2'],
        address3: json['address3'],
        phonenumber: json['phonenumber'],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": userpassword,
        "userfullname": userfullname,
        "userpassword": userpassword,
        "branchcode": branchcode,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "phonenumber": phonenumber
      };
}
