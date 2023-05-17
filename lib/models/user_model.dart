class UserModel {
  String? email;
  String? userName;
  List<dynamic>? followers;
  List<dynamic>? following;
  String? id;
  String? profilePhoto;
  List<String>? runIds;

  UserModel(
      {this.email,
      this.userName,
      this.followers,
      this.following,
      this.id,
      this.profilePhoto});

  UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map["email"],
        userName: map["userName"],
        followers: map["followers"],
        following: map["following"],
        id: map["id"],
        profilePhoto: map["profilePhoto"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "profilePhoto": profilePhoto,
      "isAdmin": false,
      "userName": userName,
      "followers": followers,
      "following": following
    };
  }
}
