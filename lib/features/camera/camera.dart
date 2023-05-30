import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class Camera extends HookWidget {
  const Camera({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isRunning = useState<bool>(true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Mjpeg(
                isLive: isRunning.value,
                error: (context, error, stack) {
                  print(error);
                  print(stack);
                  return Text(error.toString(),
                      style: const TextStyle(color: Colors.red));
                },
                stream:
                    'http://uk.jokkmokk.jp/photo/nr4/latest.jpg', //'http://192.168.1.37:8081',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
