import 'package:get/get.dart';
import 'get_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<GetController>(GetController(), permanent: true);
  }
}