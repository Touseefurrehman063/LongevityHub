// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/screens/auth_screens/signup_missing_field_screen.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> googleLogin() async {
    try {
      AuthController.i.updateisLoading(true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in canceled by user');
        AuthController.i.updateisLoading(false);
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        bool emailFound = await verifyEmailAddress(user.email);
        if (emailFound) {
          AuthController.i.email.text = user.email ?? '';
          AuthController.i.gmailAccessToken = user.uid;
          AuthController.i.accountType = '3';
          await AuthRepository().loginApi();
        } else {
          AuthController.i.name.text = user.displayName ?? '';
          AuthController.i.gmailAccessToken = user.uid;
          AuthController.i.email.text = user.email ?? '';
          AuthController.i.phone.text = user.phoneNumber ?? '';
          AuthController.i.accountType = '3';
          bool isPhoneNumberMissing =
              user.phoneNumber == null || user.phoneNumber!.isEmpty;
          bool isEmailMissing = user.email == null || user.email!.isEmpty;
          if (isPhoneNumberMissing || isEmailMissing) {
            Get.offAll(() => SignupMissingFieldScreen(
                  isPhoneNumberMissing: isPhoneNumberMissing,
                  isEmailMissing: isEmailMissing,
                ));
          } else {
            // print('Navigating to DrawerScreen');
            // Get.offAll(const DrawerScreen());
          }
        }
      } else {
        print('Error: User sign-in failed');
      }
    } catch (e) {
      print('Google login error: $e');
      if (e is PlatformException) {
        print('Error details: ${e.details}');
        print('Error code: ${e.code}');
        print('Error code: ${e.message}');
        print('Error code: ${e.message}');
        print('Error code: ${e.message}');
      }
    } finally {
      AuthController.i.updateisLoading(false);
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      print("User signed out from Google");
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        log('User account deleted');
        await _googleSignIn.signOut();
        log('User signed out from Google');
      } else {
        log('No user currently signed in');
      }
    } catch (e) {
      print('Account deletion error: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'requires-recent-login') {
          print(
              'The user must re-authenticate before this operation can be executed.');
          // Here you can prompt the user to re-authenticate
        }
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      AuthController.i.updateisLoading(true);
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          String? email = user.email;

          // If email is null, try to get email using the cell number
          email ??= await verifyEmailAddressWithCellNumber(user.phoneNumber);

          if (email != null) {
            bool emailFound = await verifyEmailAddress(email);
            if (emailFound) {
              AuthController.i.email.text = email;
              AuthController.i.faceBookAccessToken = user.uid;

              AuthController.i.accountType = '2'; // 2 is for facebook
              await AuthRepository().loginApi();
              // Add a short delay to ensure navigation happens after state update
              Future.delayed(const Duration(milliseconds: 500), () {
                // Get.offAll(() => const DrawerScreen());
              });
            } else {
              AuthController.i.name.text = user.displayName ?? '';
              // AuthController.i.pass.text = user.uid;
              // AuthController.i.confirmpass.text = user.uid;
              AuthController.i.accountType = '2';
              AuthController.i.faceBookAccessToken = user.uid;
              AuthController.i.email.text = email;
              AuthController.i.phone.text = user.phoneNumber ?? '';
              bool isPhoneNumberMissing =
                  user.phoneNumber == null || user.phoneNumber!.isEmpty;
              bool isEmailMissing = email.isEmpty;
              if (isPhoneNumberMissing || isEmailMissing) {
                Get.offAll(() => SignupMissingFieldScreen(
                      isPhoneNumberMissing: isPhoneNumberMissing,
                      isEmailMissing: isEmailMissing,
                    ));
              }
            }
          } else {
            log('Error: Could not retrieve email for the user');
          }
        } else {
          log('Error: User sign-in failed');
        }
      } else {
        log('Facebook sign-in failed: ${result.message}');
      }
    } catch (e) {
      log('Facebook login error: $e');
      if (e is PlatformException) {
        log('Error details: ${e.details}');
        log('Error code: ${e.code}');
      }
    } finally {
      AuthController.i.updateisLoading(false);
    }
  }

  Future<bool> verifyEmailAddress(String? email) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email});

    try {
      var response = await http.post(
        Uri.parse(AppConstants.verifyEmailAddress),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // Log the result for debugging
        log('API Response: $result');

        if (result == null) {
          return false;
        }

        if (result['Status'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        log('Failed to get data, status code: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Failed to get data',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0,
        );
        return false;
      }
    } catch (e) {
      log('$e exception caught');
      Fluttertoast.showToast(
        msg: 'An error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }

  Future<String?> verifyEmailAddressWithCellNumber(String? cellNumber) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': cellNumber});

    try {
      var response = await http.post(
        Uri.parse(AppConstants.verifyEmailAddressWithCellNumber),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // Log the result for debugging
        log('API Response: $result');

        if (result == null) {
          return null;
        }

        if (result['Status'] == 1) {
          return result['Email'];
        } else {
          return null;
        }
      } else {
        log('Failed to get data, status code: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Failed to get data',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0,
        );
        return null;
      }
    } catch (e) {
      log('$e exception caught');
      Fluttertoast.showToast(
        msg: 'An error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
      );
      return null;
    }
  }
}
