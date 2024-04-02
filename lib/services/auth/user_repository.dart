import 'package:ambisis_challenge/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// objetivos para futuro upgrade: retirar os métodos estáticos para permitir injeção de dependência no BLoC, para poder testar usando instâncias diferentes do firebase.
class UserRepository {
  static Future<UserModel> addUser(UserModel userModel) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("users")
        .add(userModel.toJson());

    userModel.id = documentReference.id;

    return userModel;
  }

  static Future<UserModel> getUser(String userId) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    return UserModel.fromJson(
        documentSnapshot.data() as Map<String, dynamic>, documentSnapshot.id);
  }

  static Future<UserModel> setUser(UserModel userModel) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: userModel.userId)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return await UserRepository.addUser(userModel);
    }
    return UserModel.fromJson(
        querySnapshot.docs.first.data() as Map<String, dynamic>,
        querySnapshot.docs.first.id);
  }

  // fieldID é opcional para poder modificar a field de select para a desejada.
  static Future<UserModel?> getUserByAuth(String userAuthId,
      [String fieldId = "user_id"]) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where(fieldId, isEqualTo: userAuthId)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    return UserModel.fromJson(
        querySnapshot.docs.first.data() as Map<String, dynamic>,
        querySnapshot.docs.first.id);
  }

  static Future<UserModel> createUser(
      String nickName, String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return await UserRepository.addUser(UserModel(
      nick: nickName,
      userId: userCredential.user!.uid,
    ));
  }

  static Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Future<UserModel?> userByAuth =
            UserRepository.getUserByAuth(userCredential.user!.uid);

        return userByAuth;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
