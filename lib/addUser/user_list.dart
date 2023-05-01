import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:security_camera_project/addUser/create_user.dart';
import 'package:security_camera_project/core/db/user.dart';
import 'package:security_camera_project/core/extension/extensions.dart';

class AddUser extends HookWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUser()),
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
      body: FutureBuilder<List<String>?>(
        future: UserCRUD.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('ma famma error'));
          } else if (snapshot.data == null) {
            return const Center(child: Text('ma famma 7atta user'));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => 5.h.bh,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(json.decode(snapshot.data![index])['nom']),
                    leading: const Icon(LineIcons.user),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          20.w.bw,
                          const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

