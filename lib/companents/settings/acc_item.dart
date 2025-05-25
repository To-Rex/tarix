import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resource/app_colors.dart';
import '../filds/text_small.dart';

class AccItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final GestureTapCallback? onTaps;
  final bool? switchValue;
  final Color? color;

  const AccItem({super.key, required this.title, required this.subTitle, required this.icon, required this.onTaps, this.switchValue, this.color});

  @override
  State<AccItem> createState() => _AccItemState();
}

class _AccItemState extends State<AccItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
      minVerticalPadding: 20.h,
      title: Row(
        children: [
          TextSmall(text: widget.title, color: widget.color ?? Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600,fontSize: 18.sp),
          const Spacer(),
          TextSmall(text: widget.subTitle, color: widget.color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w500,fontSize: 14.sp)
        ]
      ),
      leading: Container(
        padding: EdgeInsets.all(11.sp),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        ),
        child: Icon(widget.icon, color: widget.color ?? AppColors.lightGreen, size: 25.sp)
      ),
      trailing: widget.switchValue != null ? CupertinoSwitch(
          value: Theme.of(context).brightness == Brightness.dark ? widget.switchValue! : !widget.switchValue!,
          onChanged: (value) {

          },
          activeColor: AppColors.lightGreen,
          trackColor: AppColors.grey.withOpacity(0.5),
          focusColor: AppColors.lightGreen,
          thumbColor: Theme.of(context).colorScheme.surface,
          applyTheme: true
      ) : Icon(Icons.arrow_forward, color: widget.color ?? AppColors.grey3,
          size: 25.sp
      ),
      onTap: widget.onTaps,
    );
  }
}