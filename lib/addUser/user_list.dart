import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:security_camera_project/addUser/create_user.dart';
import 'package:security_camera_project/core/db/bloc/users_bloc.dart';
import 'package:security_camera_project/core/extension/extensions.dart';

class AddUser extends HookWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      BlocProvider.of<UsersBloc>(context).add(GetUsers());
      return null;
    }, const []);
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
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) => 5.h.bh,
              itemCount: state.userList.length,
              itemBuilder: (BuildContext context, int index) {
                print(state.userList);
                return Card(
                  child: ListTile(
                    title: Text(
                      json.decode(state.userList[index])['nom'],
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(json.decode(state.userList[index])['email']),
                    leading: const Icon(LineIcons.user),
                    trailing: SizedBox(
                      width: 120.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<UsersBloc>(context)
                                  .add(RemoveUser(index: index));
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
                                    userToUpdate:
                                        json.decode(state.userList[index]),
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
          },
        ));
  }
}
