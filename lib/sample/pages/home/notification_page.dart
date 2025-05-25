import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../companents/filds/text_small.dart';
import '../../../resource/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextSmall(text: 'Bildirishnomalar', color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w500, maxLines: 300)
          ]
        )
      )
    );
  }
}