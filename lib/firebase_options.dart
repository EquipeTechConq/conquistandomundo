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
    apiKey: 'AIzaSyDtFWQUJjprGLOAZiAKYBZDdTmYzi914pY',
    appId: '1:590905535773:web:639c6112d1d9ca648845f4',
    messagingSenderId: '590905535773',
    projectId: 'plataforma-conquistando-f33bb',
    authDomain: 'plataforma-conquistando-f33bb.firebaseapp.com',
    storageBucket: 'plataforma-conquistando-f33bb.appspot.com',
    measurementId: 'G-N6FTP07CRY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiDRbEiugP72Eel09jQZa6gDw7Pgk96T8',
    appId: '1:590905535773:android:dfdd8ba7ad324a498845f4',
    messagingSenderId: '590905535773',
    projectId: 'plataforma-conquistando-f33bb',
    storageBucket: 'plataforma-conquistando-f33bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiresnvla89isdoxtiQgCjN9NwRL_240I',
    appId: '1:590905535773:ios:857fbd0656c6d0d28845f4',
    messagingSenderId: '590905535773',
    projectId: 'plataforma-conquistando-f33bb',
    storageBucket: 'plataforma-conquistando-f33bb.appspot.com',
    iosClientId: '590905535773-3soprfdnqjut2e1ncjf6fjcu1eoeq6f0.apps.googleusercontent.com',
    iosBundleId: 'com.example.plataformaConquistandoMundo',
  );
}
