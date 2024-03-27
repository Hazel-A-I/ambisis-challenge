// ask what kind of user it is to the recruiter.

class UserModel {
  String? id;
  String userId = '';
  String nick = '';
  String avatarImage = '';

  UserModel(
      {required this.nick,
      required this.avatarImage,
      required this.userId,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json, String this.id) {
    nick = json["nick"];
    avatarImage = json["avatar_image"];

    if (json["user_id"] != null) userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    return {"nick": nick, "avatar_image": avatarImage, "user_id": userId};
  }
}
