import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_util.dart';

class WatetloFirebaseUser {
  WatetloFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

WatetloFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WatetloFirebaseUser> watetloFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<WatetloFirebaseUser>(
      (user) {
        currentUser = WatetloFirebaseUser(user);
        updateUserJwtTimer(user);
        return currentUser!;
      },
    );
