import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class FloatingMenuBottons extends StatelessWidget {
  FloatingMenuBottons({super.key});
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.up,
      pos: ExpandableFabPos.right,
      fanAngle: 180,
      childrenAnimation: ExpandableFabAnimation.rotate,
      distance: 70,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: Icon(
          Icons.add_outlined,
          size: AppLayout.getHeight(40),
        ),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: AppColors.appWhite,
        backgroundColor: AppColors.appDarkGreen,
        shape: const CircleBorder(),
        angle: 3.14 * 2,
      ),
      closeButtonBuilder: FloatingActionButtonBuilder(
          size: 56,
          builder: (BuildContext context, void Function()? onPressed,
              Animation<double> progress) =>
              FloatingActionButton(
                onPressed: onPressed,
                shape: const CircleBorder(),
                child: Icon(
                  Icons.close_outlined,
                  size: AppLayout.getHeight(40),
                  color: AppColors.appWhite,
                ),
                backgroundColor: AppColors.appDarkGreen,
              )),
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.white.withOpacity(0.9),
        blur: 5,
      ),
      children: [
        Row(
          children: [
            Text(
              translation.appQrCodeScanningTitle.tr,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold,),
            ),
            const SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: null,
              onPressed: (){
                final state = _key.currentState;
                if (state != null) {
                  state.toggle();
                }
                Get.toNamed(AppRoutes.SCANQRCODE);
              },
              backgroundColor: AppColors.appBlack,
              child: const Icon(Icons.qr_code_scanner_outlined),
            ),
          ],
        ),
        Row(
          children: [
            Text(
                translation.appHomeMenuIncomeButtonText.tr,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold,)
            ),
            SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: null,
              onPressed: (){
                final state = _key.currentState;
                if (state != null) {
                  state.toggle();
                }
              },
              backgroundColor: AppColors.appDarkGreen,
              child: Icon(Icons.trending_up_outlined, color: AppColors.appWhite,),
            ),
          ],
        ),
        Row(
          children: [
            Text(
                translation.appHomeMenuExpenseButtonText.tr,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold,)
            ),
            SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: null,
              onPressed: (){
                final state = _key.currentState;
                if (state != null) {
                  state.toggle();
                }
              },
              backgroundColor: AppColors.appRose,
              child: Icon(Icons.trending_down_outlined),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              translation.appGoalCreateGoalTitle.tr,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold,),
            ),
            SizedBox(width: 20),
            FloatingActionButton.small(
              heroTag: null,
              onPressed: (){
                final state = _key.currentState;
                if (state != null) {
                  state.toggle();
                }
              },
              backgroundColor: AppColors.appBlue,
              child: Icon(Icons.flag_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
