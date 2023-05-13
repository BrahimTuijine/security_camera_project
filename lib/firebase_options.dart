// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAFKu0Zths9cSzP2s7SK8gfA2PYVy6RqbQ',
    appId: '1:93768360440:web:713d4778b8baab5a3a360d',
    messagingSenderId: '93768360440',
    projectId: 'security-camera-a6026',
    authDomain: 'security-camera-a6026.firebaseapp.com',
    storageBucket: 'security-camera-a6026.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhoUAcBmBRU8DCcf66oPesmN2cex73hIw',
    appId: '1:93768360440:android:8772062666da33e23a360d',
    messagingSenderId: '93768360440',
    projectId: 'security-camera-a6026',
    storageBucket: 'security-camera-a6026.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4Gn-yi8hJbZjogJwHVYvpn84cmy17-uQ',
    appId: '1:93768360440:ios:cb9724af1af776463a360d',
    messagingSenderId: '93768360440',
    projectId: 'security-camera-a6026',
    storageBucket: 'security-camera-a6026.appspot.com',
    iosClientId: '93768360440-2t0hgkffqlcu6u3rn0pkhhgtopagq9qn.apps.googleusercontent.com',
    iosBundleId: 'com.example.securityCameraProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4Gn-yi8hJbZjogJwHVYvpn84cmy17-uQ',
    appId: '1:93768360440:ios:cb9724af1af776463a360d',
    messagingSenderId: '93768360440',
    projectId: 'security-camera-a6026',
    storageBucket: 'security-camera-a6026.appspot.com',
    iosClientId: '93768360440-2t0hgkffqlcu6u3rn0pkhhgtopagq9qn.apps.googleusercontent.com',
    iosBundleId: 'com.example.securityCameraProject',
  );
}
