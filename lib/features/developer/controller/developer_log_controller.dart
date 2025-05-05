import 'package:get/get.dart';

class DeveloperLogController extends GetxController {
  static DeveloperLogController get to => Get.find();

  final RxList<String> logs = <String>[].obs;
  final RxBool isVisible = false.obs;

  void log(String message) {
    logs.add("${DateTime.now()}: $message");
    // Keep only last 100 logs
    if (logs.length > 100) {
      logs.removeRange(0, logs.length - 100);
    }
  }

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void clearLogs() {
    logs.clear();
  }
} 