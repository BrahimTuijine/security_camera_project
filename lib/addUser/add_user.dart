import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:security_camera_project/core/extension/extensions.dart';

class AddUser extends HookWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
      body: ListView.separated(
        separatorBuilder: (context, index) => 5.h.bh,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: const Text('brahim tuijine'),
              leading: const Icon(LineIcons.user),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
