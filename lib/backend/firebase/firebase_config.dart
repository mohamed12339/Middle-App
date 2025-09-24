import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAbOOjwb4-ZaBPXs3ckIA7vkVJ-LdAKyhI",
            authDomain: "ioio-80f80.firebaseapp.com",
            projectId: "ioio-80f80",
            storageBucket: "ioio-80f80.appspot.com",
            messagingSenderId: "843791264422",
            appId: "1:843791264422:web:fcb9f1e3ec4b016f966267",
            measurementId: "G-Q66G6W8LQP"));
  } else {
    await Firebase.initializeApp();
  }
}
