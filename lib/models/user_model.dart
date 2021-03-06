class UserModel {
  String uid = "";
  late String fullName;
  late String email;
  late String password;
  String? imageUrl;
  bool followed = false;
  int followersCount = 0;
  int followingCount = 0;

  String device_id = "";
  String device_type = "";
  String device_token = "";

  UserModel({required this.fullName, required this.email, required this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    fullName = json["fullName"];
    email = json["email"];
    password = json["password"];
    imageUrl = json["imageUrl"];
    followersCount = json["followersCount"];
    followingCount = json["followingCount"];
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "fullName": fullName,
    "email": email,
    "password": password,
    "imageUrl": imageUrl,
    "followingCount": followingCount,
    "followersCount": followersCount,
  };

  @override
  bool operator == (Object other) {
    return other is UserModel && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}
