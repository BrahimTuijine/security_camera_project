import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:security_camera_project/core/Model/notification_model.dart';

class NotificationList {
  static Stream<List<NotificationModel>> getNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                // print(e.data());
                Map<String, dynamic> map = {"id": e.id, ...e.data()};
                final result = NotificationModel.fromJson(map);
                return result;
              },
            ).toList());
  }
}
