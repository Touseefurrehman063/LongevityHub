// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/helpers/exception/exception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get i => Get.find();

  //variable
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> fireBaseUser;
  @override
  void onReady() {
    fireBaseUser = Rx<User?>(_auth.currentUser);
    fireBaseUser.bindStream(_auth.userChanges());
  }

  Future<void> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // AuthController.i.saveupdateduserid(user.uid);
        log("User created with UID: ${user.uid}");
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpwithEmailandPasswordFailure.code(e.code);
      // Utils.toastMessage(ex.message, Colors.red, Colors.white);
      log("Firbase Auth Exception - ${ex.message}");
    } catch (_) {
      const ex = SignUpwithEmailandPasswordFailure();
      log("Exception - ${ex.message}");
      throw ex;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException {
      const ex = "Failed";
    }
  }
}
