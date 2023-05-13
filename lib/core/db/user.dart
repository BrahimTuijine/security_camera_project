import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:security_camera_project/core/Model/userModel.dart';

class UserCRUD {
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  static Stream<List<UserModel>> getUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                final result = UserModel.fromJson(e.data());
                return result;
              },
            ).toList());
  }

  Future<void> addUser(Map<String, String> user) async {
    await userRef.add(user);
  }

  Future<void> updateUser(
      {required Map<String, String> newUser, required String docId}) async {
    await userRef.doc(docId).update(newUser);
  }

  Future<void> deleteUser({required String docId}) async {
    await userRef.doc(docId).delete();
  }

  // Future<bool> isThisUserFound(
  //     {required String email, required String passowrd}) async {
  //   await for (final result in getUsers()) {
  //     final user = result.where((element) => element.email == email).toList();
  //     if (user.isNotEmpty) {
  //       return user.first.password == passowrd;
  //     } else {
  //       return false;
  //     }
  //   }

  //   return false;
  // }
}
