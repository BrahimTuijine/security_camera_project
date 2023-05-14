import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:security_camera_project/core/Model/userModel.dart';
import 'package:security_camera_project/core/db/user.dart';
import 'package:security_camera_project/core/extension/extensions.dart';
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
        builder: (context, snapshot) {
          // print(snapshot.data);
          print(snapshot.data);
          // final List<UserModel> users = [];

          // for (var user in snapshot.data!.reversed.toList()) {
          //   users.add(UserModel.fromJson(user as Map<String, String>));
          // }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucun utilisateur trouve'));
            }
            return ListView.separated(
              separatorBuilder: (context, index) => 5.h.bh,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].name!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(snapshot.data![index].email!),
                    leading: const Icon(LineIcons.user),
                    trailing: SizedBox(
                      width: 120.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              UserCRUD()
                                  .deleteUser(docId: snapshot.data![index].id!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateUpdateUser(
                                    userToUpdate: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
