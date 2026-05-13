import 'package:flutter/foundation.dart';

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
        return macOS:
        case TargetPlatform.windows:
        return windows;
        case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.'
        );
        default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platforms.',
        );
    }
  }static const FirebaseOptions web = FirebaseOptions(
    apiKey:
  )
}
