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
                // print(e.data());
                Map<String, dynamic> map = {"id": e.id, ...e.data()};
                final result = UserModel.fromJson(map);
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

  Future<bool> isThisUserFound(
      {required String email, required String passowrd}) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");

    // final List users = [];

    final mylist = await userRef
        // .where('email', isEqualTo: email.trim())
        // .where('password', isEqualTo: passowrd.trim())
        .get();

    for (var element in mylist.docs) {
      final data = element.data() as Map;
      if (data['email'].trim() == email.trim()) {
        return true;
      }
    }
    return false;
  }
}
