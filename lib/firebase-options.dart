import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyCeQ78cw-i74enEtowDoCGwifGJ5itOwxk",
      authDomain: "control-access-406b6.firebaseapp.com",
      projectId: "control-access-406b6",
      storageBucket:
          "control-access-406b6.appspot.com", // Convertimos a formato correcto
      messagingSenderId: "671680280087",
      appId: "1:671680280087:android:75e8bca92784ecb1d48e52",
    );
  }
}
