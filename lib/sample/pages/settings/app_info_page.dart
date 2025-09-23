import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/api_controller.dart';
import '../../../controllers/get_controller.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final GetController getController = Get.put(GetController());
    final ApiController apiController = Get.put(ApiController());

    // Set height and width once
    getController.setHeightWidth(context);

    // Fetch app info only once when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      apiController.appInfo();
    });

    final customStyles = {
      'p': Style(
        fontSize: FontSize(16),
        color: Colors.black87,
        lineHeight: const LineHeight(1.5),
        padding: HtmlPaddings.only(bottom: 8),
      ),
      'h1': Style(
        fontSize: FontSize(24),
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[900],
        padding: HtmlPaddings.only(bottom: 16, top: 8),
      ),
      'h2': Style(
        fontSize: FontSize(20),
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[800],
        padding: HtmlPaddings.only(bottom: 12, top: 8),
      ),
      'ul': Style(
        padding: HtmlPaddings.only(left: 16, bottom: 8),
      ),
      'li': Style(
        fontSize: FontSize(16),
        color: Colors.black87,
        padding: HtmlPaddings.only(bottom: 4),
      ),
      'a': Style(
        color: Colors.blue,
        textDecoration: TextDecoration.underline,
        fontWeight: FontWeight.w500,
      ),
      'strong': Style(
        fontWeight: FontWeight.bold,
      ),
      'em': Style(
        fontStyle: FontStyle.italic,
      ),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: Obx(() => Text(getController.appInfoModel.value.data?.title ?? 'AppInfo')),
        centerTitle: true,
      ),
      body: Obx(() {
        final appInfo = getController.appInfoModel.value;
        if (appInfo.data?.content == null) {
          return const Center(child: Text('No content available'));
        }
        return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Html(
          data: appInfo.data!.content!,
            style: customStyles,
          ),
          )
        );
      }),
    );
  }
}