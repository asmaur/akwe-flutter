import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPageController extends GetxController{
  final MobileScannerController scannerController = MobileScannerController(
      formats: const [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.noDuplicates
  );

  StreamSubscription<Object?>? _subscription;
  // final service = PetService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() async{
    // Stop listening to lifecycle changes.
    // WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    debugPrint("dispose");
    super.dispose();
    await scannerController.stop();
  }

  @override
  void onClose() async{
    super.onClose();
    debugPrint("Close");
    await scannerController.dispose();
  }


}