// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD8Y46DphOVNiHJbn6Lob5S_alM-hGP0Xs',
    appId: '1:274335731810:web:8f4a5a79c5dd616782013b',
    messagingSenderId: '274335731810',
    projectId: 'trashify-mobile',
    authDomain: 'trashify-mobile.firebaseapp.com',
    storageBucket: 'trashify-mobile.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9lpKjCmqrdn3qFF2qbVZB5BsLtFoYpMw',
    appId: '1:274335731810:android:3e953ca37f324a7882013b',
    messagingSenderId: '274335731810',
    projectId: 'trashify-mobile',
    storageBucket: 'trashify-mobile.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrDK5WEveEqDgBTRyQHOOYzFamSleCHOU',
    appId: '1:274335731810:ios:b3b424107d4a982482013b',
    messagingSenderId: '274335731810',
    projectId: 'trashify-mobile',
    storageBucket: 'trashify-mobile.appspot.com',
    androidClientId: '274335731810-69tthie2jhjhpiu0evrfi8q15j8h3c2c.apps.googleusercontent.com',
    iosClientId: '274335731810-3kvmrbuisr477fn8afm3tch4h3jg68nt.apps.googleusercontent.com',
    iosBundleId: 'com.example.trashify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrDK5WEveEqDgBTRyQHOOYzFamSleCHOU',
    appId: '1:274335731810:ios:b3b424107d4a982482013b',
    messagingSenderId: '274335731810',
    projectId: 'trashify-mobile',
    storageBucket: 'trashify-mobile.appspot.com',
    androidClientId: '274335731810-69tthie2jhjhpiu0evrfi8q15j8h3c2c.apps.googleusercontent.com',
    iosClientId: '274335731810-3kvmrbuisr477fn8afm3tch4h3jg68nt.apps.googleusercontent.com',
    iosBundleId: 'com.example.trashify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD8Y46DphOVNiHJbn6Lob5S_alM-hGP0Xs',
    appId: '1:274335731810:web:65ab20ea04c3ff3d82013b',
    messagingSenderId: '274335731810',
    projectId: 'trashify-mobile',
    authDomain: 'trashify-mobile.firebaseapp.com',
    storageBucket: 'trashify-mobile.appspot.com',
  );

}