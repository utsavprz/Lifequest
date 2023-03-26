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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCAYTTfwuU2LvcUab0uepr16zbMEEghKfA',
    appId: '1:284041441502:web:0951d833b2dc1a4828124f',
    messagingSenderId: '284041441502',
    projectId: 'lifequest-1357f',
    authDomain: 'lifequest-1357f.firebaseapp.com',
    storageBucket: 'lifequest-1357f.appspot.com',
    measurementId: 'G-N562WYV8B5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMNyjq0uOz9xdzaDKp8MMUWE-JRUzErzY',
    appId: '1:284041441502:android:4dba96c064c9975628124f',
    messagingSenderId: '284041441502',
    projectId: 'lifequest-1357f',
    storageBucket: 'lifequest-1357f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_obkfQR-lcGf4lxHCnnEB8ZE7h_6n5gQ',
    appId: '1:284041441502:ios:ab364ef050e08dfb28124f',
    messagingSenderId: '284041441502',
    projectId: 'lifequest-1357f',
    storageBucket: 'lifequest-1357f.appspot.com',
    iosClientId: '284041441502-q0qh6ije82os91e537baqq2desrq5ddb.apps.googleusercontent.com',
    iosBundleId: 'com.softwarica.lifequest',
  );
}
