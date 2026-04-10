// Below code onlu works for Android/iOS. For web, you need to use signInWithPopup instead of signInWithCredential. Check the official documentation for more details.

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   //Google Sign In
//   SignInWithGoogle() async {
//     // begin interactive sign in process
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     // obtain auth details from request
//     GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     // create a new credential for user
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     // finally, lets sign in
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }

// Below code works for both web and mobile platforms.

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      // Web
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      return await FirebaseAuth.instance.signInWithPopup(authProvider);
    } else {
      // Mobile (Android/iOS)
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }
}
