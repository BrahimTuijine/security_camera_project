import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:security_camera_project/core/Model/sensors_model.dart';

class SensorsCRUD {
  CollectionReference userRef =
      FirebaseFirestore.instance.collection("sensors");

  static Stream<List<SensorModel>> getSensors() {
    return FirebaseFirestore.instance
        .collection('sensors')
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                // print(e.data());
                Map<String, dynamic> map = {"id": e.id, ...e.data()};
                final result = SensorModel.fromJson(map);
                return result;
              },
            ).toList());
  }

  Future<void> addSensor(Map<String, String> sensor) async {
    await userRef.add(sensor);
  }

  Future<void> updateSensor(
      {required Map<String, String> sensor, required String docId}) async {
    await userRef.doc(docId).update(sensor);
  }

  Future<void> deleteSensor({required String docId}) async {
    await userRef.doc(docId).delete();
  }
}
