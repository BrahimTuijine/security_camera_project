import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/core/Model/userModel.dart';
import 'package:security_camera_project/core/db/user.dart';
import 'package:security_camera_project/features/addUser/create_user.dart';

class AddUser extends HookWidget {
  AddUser({Key? key}) : super(key: key);

  final users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUpdateUser()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'User list',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: UserCRUD.getUsers(),
        initialData: const [],
        builder: (context, snapshot) {
          return Container();
          // print(snapshot.data);
          // final List<UserModel> users = [];

          // for (var user in snapshot.data!.docs.reversed.toList()) {
          //   users.add(UserModel.fromJson(user as Map<String, String>));
          // }

          // return ListView.separated(
          //   separatorBuilder: (context, index) => 5.h.bh,
          //   itemCount: snapshot.data!.docs.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Card(
          //       child: ListTile(
          //         title: Text(
          //           users[index].name,
          //           style: TextStyle(
          //               fontSize: 16.sp, fontWeight: FontWeight.w500),
          //         ),
          //         subtitle: Text(users[index].email),
          //         leading: const Icon(LineIcons.user),
          //         trailing: SizedBox(
          //           width: 120.w,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               IconButton(
          //                 onPressed: () {
          //                   // BlocProvider.of<UsersBloc>(context)
          //                   //     .add(RemoveUser(index: index));
          //                 },
          //                 icon: const Icon(
          //                   Icons.delete,
          //                   color: Colors.red,
          //                 ),
          //               ),
          //               IconButton(
          //                 onPressed: () {
          //                   // Navigator.push(
          //                   //   context,
          //                   //   MaterialPageRoute(
          //                   //     builder: (context) => CreateUpdateUser(
          //                   //       index: index,
          //                   //       userToUpdate: state.userList[index],
          //                   //     ),
          //                   //   ),
          //                   // );
          //                 },
          //                 icon: const Icon(
          //                   Icons.edit,
          //                   color: Colors.green,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
