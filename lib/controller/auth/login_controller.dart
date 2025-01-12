import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.toNamed('/navbar');
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xff846c68),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: const Text(
              "Invalid Email",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (e.code == "invalid-credential") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xff846c68),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: const Text(
              "Invalid Credential",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xff846c68),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: const Text(
              "Wrong Password",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xff846c68),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: const Text(
              "User not found",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xff846c68),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: const Text(
              "Something else happened!",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xff846c68),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text(
            e.toString(),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  Future<void> googleLogin(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xff846c68),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text(
            "Success! Signed in using ${userCredential.user?.email}",
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      Get.toNamed('/navbar');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xff846c68),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: const Text(
            "User sign in failed!",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
