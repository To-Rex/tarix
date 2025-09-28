import 'dart:io';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../pages/error_page.dart';


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

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
      // Apple'dan kelgan ma'lumotlarni logda ko'rish
      print("Apple Email: ${credential.email}");
      print("Apple Full Name: ${credential.givenName} ${credential.familyName}");
      print("Apple Locale: ${credential.state}");
      print("Apple Identity Token: ${credential.identityToken}");
      print("Apple User ID: ${credential.userIdentifier}");
      print("Apple Authorization Code: ${credential.authorizationCode}");

      //var fullName = '${credential.givenName ?? ''} ${credential.familyName ?? ''}';
      var fullName = '${credential.givenName ?? ''}${credential.givenName != null ? ' ' : ''}${credential.familyName ?? ''}';
      var email = credential.email ?? '';
      var appleId = credential.userIdentifier ?? '';
      var appleIdentityToken = credential.identityToken ?? '';
      await ApiController().loginApple(email, fullName, '', appleId, appleIdentityToken);
    } catch (e) {
      print("Apple Sign-In error: $e");
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
                          signInWithGoogle();
                        },
                        text: 'Google orqali kirish'.tr,

                        style: AuthButtonStyle(
                          width: Get.width,
                          elevation: 0,
                          buttonColor: AppColors.white,
                          borderColor: AppColors.grey,
                          textStyle: TextStyle(fontFamily: 'Schyler', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                              iconColor: AppColors.black,
                              iconSize: 24.w,
                              textStyle: TextStyle(fontFamily: 'Schyler', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                            signInWithApple();
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