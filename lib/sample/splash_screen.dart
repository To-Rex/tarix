import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import 'auth/login_page.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  Future<void> open() async {
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