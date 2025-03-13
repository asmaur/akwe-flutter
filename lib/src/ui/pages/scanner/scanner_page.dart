import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/widgets/scanner_buttons/scanner_buttons_widgets.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page_controller.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class ScannerPage extends StatelessWidget {
  ScannerPage({super.key});

  final controller = Get.put(ScannerPageController());

  // final MobileScannerController controller = MobileScannerController(
  //   // formats: const [BarcodeFormat.qrCode],
  // );

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appQrCodeScanningTitle.tr),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              fit: BoxFit.contain,
              controller: controller.scannerController,
              onDetect: (capture) {
                String invoiceURL = capture.barcodes.firstOrNull!.rawValue!;
                debugPrint(invoiceURL);
                Get.offNamed(AppRoutes.QRCODEFOUND, arguments: invoiceURL);

              },
              // scanWindow: scanWindow,
              // errorBuilder: (context, error, child) {
              //   return ScannerErrorWidget(error: error);
              // },
              // overlayBuilder: (context, constraints) {
              //   return Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Align(
              //       alignment: Alignment.bottomCenter,
              //       child: ScannedBarcodeLabel(barcodes: controller.barcodes),
              //     ),
              //   );
              // },
            ),
          ),
          QRScannerOverlay(overlayColour: Colors.white.withOpacity(0.5)),

          // ValueListenableBuilder(
          //   valueListenable: controller,
          //   builder: (context, value, child) {
          //     if (!value.isInitialized ||
          //         !value.isRunning ||
          //         value.error != null) {
          //       return const SizedBox();
          //     }
          //
          //     return CustomPaint(
          //       painter: ScannerOverlay(scanWindow: scanWindow),
          //     );
          //   },
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ToggleFlashlightButton(controller: controller.scannerController),
                  SwitchCameraButton(controller: controller.scannerController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
//
// @override
// Future<void> dispose() async {
//   // super.dispose();
//   await controller.dispose();
// }

}


class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({Key? key, required this.overlayColour})
      : super(key: key);

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;
    return Stack(children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(
            overlayColour, BlendMode.srcOut), // This one will create the magic
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.red,
                  backgroundBlendMode: BlendMode
                      .dstOut), // This one will handle background + difference out
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: scanArea,
                width: scanArea,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: CustomPaint(
          foregroundPainter: BorderPainter(),
          child: SizedBox(
            width: scanArea + 25,
            height: scanArea + 25,
          ),
        ),
      ),
    ]);
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(size.width - 44, size.height - 44), radius: 40))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}