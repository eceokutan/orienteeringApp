class UserModel {
  String? userName;
  int? followerCount;
  int? followingCount;
  String? _email;
  String? id;
  String? profilePhoto;
  //List<String>? runIds;

  // getters setters
  String get email {
    return _email ?? "";
  }

  set email(String email) {
    if (!email.contains("@")) {
      throw Exception("Email is not valid");
    }
    _email = email;
  }

  UserModel();

  UserModel fromMap(Map<String, dynamic> map) {
    UserModel user = UserModel();

    user.email = map["email"];
    user.userName = map["userName"];
    user.followerCount = map["followerCount"];
    user.followingCount = map["followingCount"];
    user.id = map["id"];
    user.profilePhoto = map["profilePhoto"];

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "profilePhoto": profilePhoto,
      "isAdmin": false,
      "userName": userName,
      "followerCount": followerCount,
      "followingCount": followingCount
    };
  }
}
