import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tarix/companents/filds/text_small.dart';
import '../../../controller/get_controller.dart';
import '../../../resource/app_colors.dart';

class QuestionInfoPage extends StatelessWidget {
  QuestionInfoPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: TextSmall(text: 'Test natijalari', color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w500, maxLines: 300),
          ],
        ),
      ),
    );
  }
}