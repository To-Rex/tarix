import 'dart:io';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tarix/controller/api_controller.dart';
import 'package:tarix/resource/app_colors.dart';
import 'package:tarix/sample/pages/error_page.dart';
import '../../companents/filds/text_small.dart';
import '../../controller/get_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GetController _getController = Get.put(GetController());

  static const List<String> scopes = <String>['email', 'https://www.googleapis.com/auth/contacts.readonly'];

  Future<void> performAppleSignIn(BuildContext context) async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
      print(result);
      print(result.authorizationCode);
      print(result.email);
      print(result.givenName);
      print(result.identityToken);
    } catch (error) {
      print(error);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Xato', 'Foydalanuvchi kirishni bekor qildi'.tr);
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print('ID: ${googleUser.id}');
      print('Email: ${googleUser.email}');
      print('Display Name: ${googleUser.displayName}');
      print('Photo URL: ${googleUser.photoUrl}');
      await ApiController().login(googleUser.email, googleUser.displayName ?? '', googleUser.photoUrl ?? '', googleUser.id);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign-In Error: $e');
      if (e.toString().contains('com.google.android.gms.common.api')) {
        Get.snackbar('Xato', 'Google Play Services o‘rnatilmagan yoki yangilanmagan. Iltimos, yangilang.'.tr);
      } else {
        Get.offAll(() => const ErrorPage());
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('LoginPage');
    debugPrint(_getController.token);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.68,
                  child: Image.asset('assets/images/auth_fon.png', fit: BoxFit.cover),
                ),
                SizedBox(height: 30.h),
                Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: Get.height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSmall(text: 'Dasturga kirish'.tr, fontSize: 28.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                      SizedBox(height: 5.h),
                      TextSmall(text: 'Google akkaunt orqali dasturga kiring'.tr, fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.black),
                      SizedBox(height: 28.h),
                      if (Platform.isAndroid)
                      GoogleAuthButton(
                        onPressed: () {
                          print('Google orqali kirish=====================================================');
                          //googleSignIn();
                          signInWithGoogle();
                        },
                        text: 'Google orqali kirish'.tr,
                        style: AuthButtonStyle(
                          width: Get.width,
                          elevation: 0,
                          buttonColor: AppColors.white,
                          borderColor: AppColors.grey,
                          shadowColor: Colors.transparent,
                          splashColor: AppColors.grey.withAlpha(50),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          borderWidth: 1.w,
                          borderRadius: 12.r
                        ),
                      ),
                      if (Platform.isIOS)
                        AppleAuthButton(
                          style: AuthButtonStyle(
                              width: Get.width,
                              elevation: 0,
                              borderColor: AppColors.grey,
                              buttonColor: AppColors.white,
                              shadowColor: Colors.transparent,
                              splashColor: AppColors.grey.withAlpha(50),
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              borderWidth: 1.w,
                              borderRadius: 12.r
                          ),
                          onPressed: () {
                            //googleSignIn();
                            signInWithGoogle();
                            //performAppleSignIn(context);
                          },
                        )
                    ]
                  )
                )
              ]
            )
          ),
          Positioned(
            top: Get.height * 0.68 - 45.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Get.width,
                  height: 90.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  margin: EdgeInsets.symmetric(horizontal: 60.w),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r, spreadRadius: 0.r, offset: const Offset(0, 1))], borderRadius: BorderRadius.all(Radius.circular(20.r))),
                  child: Row(
                    children: [
                      Container(
                        width: 70.w,
                        height: 90.h,
                        margin: EdgeInsets.only(right: 10.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          border: Border.all(color: Colors.black12, width: 5)
                        ),
                        padding: EdgeInsets.all(3.w),
                        child: Image.asset('assets/images/splash_logo.png', width: 70.w, height: 70.h)
                      ),
                      Expanded(child: TextSmall(text: 'O‘ZBEKISTON TARIXI VA HUQUQSHUNOSLIK', fontSize: 18.sp, fontWeight: FontWeight.bold, maxLines: 2))
                    ]
                  )
                )
              ]
            )
          )
        ],
      )
    );
  }
}