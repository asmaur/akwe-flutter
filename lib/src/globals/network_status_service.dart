import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class NetworkStatusService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  Future<NetworkStatusService> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void _updateConnectivityStatus(List<ConnectivityResult> connectivityResult) {

    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.rawSnackbar(
        messageText: const Text(
          "PLEASE CONNECT TO THE INTERNET",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        isDismissible: true,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red[400]!,
        icon: Icon(
          Icons.wifi_off_outlined,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      Get.closeCurrentSnackbar();
    }
  }
}
