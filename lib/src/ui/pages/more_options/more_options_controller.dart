import 'package:get/get.dart';
import 'package:poupey/src/globals/app_premium_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptionsController extends GetxController{
  final premiumService = Get.find<AppPremiumService>();

  Future<void> openUrl(String url) async {
    final url0 = Uri.parse(url);
    if (!await launchUrl(url0, mode: LaunchMode.externalApplication)) { // <--
      throw Exception('Could not launch $url0');
    }
  }
}