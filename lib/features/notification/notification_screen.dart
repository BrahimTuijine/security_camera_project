import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/Model/notification_model.dart';
import 'package:security_camera_project/core/db/notifications.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';

class NotificationPage extends HookWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    final Animation<Offset> animationTran =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(controller);

    useEffect(() {
      controller.forward();
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "Notifications"),
      body: StreamBuilder<List<NotificationModel>>(
        stream: NotificationList.getNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun notification trouve'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (
                context,
                index,
              ) {
                return SlideTransition(
                  position: animationTran,
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].title.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Handle notification tap here
                    },
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
