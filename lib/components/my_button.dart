import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renuka_travels/auth/auth_service.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF4AC20),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}


class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    super.key,
    required this.kheight,
  });

  final double kheight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        UserCredential? userCredential =
            await AuthService().signInWithGoogle(context);
        if (userCredential != null) {
          // Redirect to the home page
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Show an error message if needed
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Google sign-in failed. Please try again."),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFF4AC20)),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/google-logo.png",
              height: kheight * 0.025,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Continue with Google",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}