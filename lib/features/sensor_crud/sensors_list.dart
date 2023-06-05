import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/Model/sensors_model.dart';
import 'package:security_camera_project/core/db/sensors.dart';
import 'package:security_camera_project/core/extension/extensions.dart';
import 'package:security_camera_project/features/sensor_crud/create_update_sensor.dart';

class SensorList extends HookWidget {
  const SensorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUpdateSensor()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sensors list',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<SensorModel>>(
        stream: SensorsCRUD.getSensors(),
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
              return const Center(child: Text('Aucun capteur trouve'));
            }
            return ListView.separated(
              separatorBuilder: (context, index) => 5.h.bh,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].sensorType!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(snapshot.data![index].refrences!),
                    leading: const Icon(Icons.sensors_outlined),
                    trailing: SizedBox(
                      width: 120.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              SensorsCRUD().deleteSensor(
                                  docId: snapshot.data![index].id!);
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
                                  builder: (context) => CreateUpdateSensor(
                                    sensorToUpdate: snapshot.data![index],
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
