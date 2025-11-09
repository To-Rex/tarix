import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import 'auth/login_page.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  Future<void> open() async {
    //_getController.saveToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6InRvcmV4LmFtYWtpQGljbG91ZC5jb20iLCJmdWxsX25hbWUiOiJEaWxzaG9kam9uIEhheWRhcm92IiwiYXBwbGVfaWQiOiIwMDA0ODEuMTBhZjM1MDg5NzE0NDc3OTk1ZTYyOTY1MDcyYmZhYmYuMjEyOSIsImdvb2dsZV9pZCI6bnVsbCwiaWQiOiI2OGQ4MDM5ZGIwZjY2NGI2YWVjYWU3YzYiLCJyb2xlIjoibW9iaWxlLXVzZXIiLCJpYXQiOjE3NTkwNDE2ODgsImV4cCI6MTc1OTY0NjQ4OH0.nB_-9T0FdlIluhKqqKfXqOLwkbJ0KtJ9q2M_OwtZvrw');

    if (_getController.token != null && _getController.token!.isNotEmpty) {
      ApiController().getMe();
    } else {
      Get.offAll(() => LoginPage(), transition: Transition.fadeIn);
    }
  }
  @override
  Widget build(BuildContext context) {
    _getController.tapTimes(open, 1);
    //_getController.tapTimes(() {Get.offAll(() => LoginPage());}, 1);
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 170,
            height: 170,
            child: Stack(
              children: [
                Positioned.fill(child: Center(child: Image.asset('assets/images/splash_logo.png'))),
                Positioned.fill(
                    child: SizedBox(
                        width: 170,
                        height: 170,
                        child: CircularProgressIndicator(
                            strokeWidth: 13,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation(Colors.grey)
                        )
                    )
                )
              ]
            )
        )
      )
    );
  }
}