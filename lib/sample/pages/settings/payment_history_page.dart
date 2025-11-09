import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:history/controllers/api_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../companents/filds/text_small.dart';
import '../../../companents/home/payment_history_item.dart';
import '../../../companents/home/quiz_item.dart';
import '../../../companents/refresh_component.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class PaymentHistoryPage extends StatelessWidget {
  PaymentHistoryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    ApiController().getPaymentHistory();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor:  AppColors.white, surfaceTintColor: AppColors.white, title: TextSmall(text: 'To’lovlar tarixi', color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500), centerTitle: true),
        body: RefreshComponent(
            color: AppColors.black,
            scrollController: _getController.scrollPaymentHistoryController,
            refreshController: _getController.refreshPaymentHistoryController,
            enablePullUp: false,
            physics: const ClampingScrollPhysics(),
            onRefresh: () async {
              _getController.clearQuizModel();
              ApiController().getPaymentHistory().then((value){
                _getController.refreshPaymentHistoryController.refreshCompleted();
                _getController.refreshPaymentHistoryController.loadComplete();
              });
            },
            child: Obx(() => _getController.paymentHistory.value.data != null
                ? _getController.paymentHistory.value.data!.isNotEmpty
                ? ListView.builder(
              itemCount: (_getController.paymentHistory.value.data?.length ?? 0),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 45.h),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                // Quiz items for other indices
                final dataIndex = index ;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: PaymentHistoryItem(
                    sId: _getController.paymentHistory.value.data![dataIndex].sId.toString(),
                    index: dataIndex,
                    payment: _getController.paymentHistory.value.data![dataIndex].paymentAmount.toString(),
                    data: _getController.paymentHistory.value.data![dataIndex].paymentDate.toString(),
                  ),
                );
              },
            )
                : Container(
                width: 1.sw,
                margin: const EdgeInsets.only(top: 18),
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                constraints: BoxConstraints(minHeight: Get.height - 200.h),
                decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
                alignment: Alignment.center,
                child: TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500))
                : ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(padding: EdgeInsets.symmetric(horizontal: 15.w), child: Skeletonizer(child: PaymentHistoryItem(sId: '92nsakskqskoqs', index: index, payment: 'Question', data: 'Answer')))))
        )
    );
  }
}