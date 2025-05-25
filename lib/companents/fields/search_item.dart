import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/get_controller.dart';
import '../../resource/app_colors.dart';

class SearchItem extends StatelessWidget {
  final GetController _getController;
  final Function(String) onChanged;

  SearchItem({
    super.key,
    required this.onChanged,
    GetController? getController,
  }) : _getController = getController ?? Get.find<GetController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 50.h,
      margin: const EdgeInsets.only(top: 18, left: 15, right: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: AppColors.grey6),
      ),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _getController.searchQuizController,
        builder: (context, value, child) {
          return TextField(
            controller: _getController.searchQuizController,
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              border: InputBorder.none,
              hintText: 'Qidirish',
              hintStyle: TextStyle(color: AppColors.grey, fontSize: 16.sp),
              prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 24.sp),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  _getController.searchQuizController.clear();
                  onChanged('');
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                icon: Icon(Icons.clear, color: AppColors.grey, size: 24.sp),
              )
                  : const SizedBox.shrink(),
            ),
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(color: AppColors.black, fontSize: 16.sp),
            cursorColor: AppColors.black,
          );
        },
      ),
    );
  }
}