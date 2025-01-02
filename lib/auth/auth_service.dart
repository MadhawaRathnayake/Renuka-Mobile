import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instance of FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Google Sign In
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      // Show progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in screen
      if (gUser == null) {
        Navigator.of(context).pop(); // Dismiss the progress indicator
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with credential
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      Navigator.of(context).pop(); // Dismiss the progress indicator
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); // Dismiss the progress indicator

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Google Sign-In failed: ${e.message ?? 'An error occurred.'}",
        ),
        backgroundColor: Colors.red,
      ));
      return null;
    }
  }
}
