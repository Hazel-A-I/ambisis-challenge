class UserModel {
  String? id;
  String userId = '';
  String nick = '';

  UserModel({required this.nick, required this.userId, this.id});

  UserModel.fromJson(Map<String, dynamic> json, String this.id) {
    nick = json["nick"];
    userId = json["user_id"];
  }

  Map<String, dynamic> toJson() => {"nick": nick, "user_id": userId};
}
