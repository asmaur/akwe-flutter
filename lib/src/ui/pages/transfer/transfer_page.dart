import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/transfer/transfer_page_controller.dart';
import 'package:akwe/src/ui/widgets/transfer/transfer_tile.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TransferPage extends StatelessWidget {
  TransferPage({super.key});

  final controller = Get.find<TransferPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.appTransferTitleText.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
        ),
        actions: [
          IconButton(onPressed: (){Get.toNamed(AppRoutes.NEWTRANSFER);}, icon: const Icon(Icons.add))
        ],
      ),
      // drawer: const AppDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.toNamed(Routes.NEWTRANSFER);
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: AppColors.appMidYellow,
      // ),
      body: RefreshIndicator(
        onRefresh: () => controller.getTransfers(),
        child: Obx(
              () => controller.transfers.isNotEmpty
              ? ListView.separated(
            itemCount: controller.transfers.length,
            //shrinkWrap: true,
            //physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: AppLayout.getHeight(25),
                  right: AppLayout.getHeight(25),
                ),
                child:
                TransferTile(transfer: controller.transfers[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              // if (index % 2 == 0) {
              //   return AppAdManager().getBannerAd();
              // } else if (controller.transfers.length - 1 == index) {
              //   return AppAdManager().getBannerAd();
              // }
              return const SizedBox();
            },
          )
              : ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: AppLayout.getScreenHeight() * 0.4,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/empty-list.png"),
                ),
              ),
              Gap(AppLayout.getHeight(15)),
              Center(
                child: Text(
                  translation.userTransactionNoTransactionFoundText.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
