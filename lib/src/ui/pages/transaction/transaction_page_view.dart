import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/pages/transaction/transaction_page_view_controller.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:akwe/src/ui/widgets/components/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TransactionPageView extends StatelessWidget {
  TransactionPageView({super.key});
  final TransactionPageViewController controller =
  Get.put(TransactionPageViewController()); //find<TransactionController>();
  // final paymentTypes = getPaymentTypeList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translation.userTransactionPageTitle.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),
          //automaticallyImplyLeading: false,
          actions: [
            //ItemDropdownFilter(),
            IconButton(
              onPressed: () {
                // controller.getCurrentTransaction();
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                // Get.toNamed(Routes.TRANSACTIONFILTER);
              },
              icon: const Icon(Icons.filter_alt),
            ),

          ],
        ),
      drawer: AppDrawerMobile(),
      body: RefreshIndicator(
        onRefresh: () => controller.getCurrentTransaction(),
        child: Obx(
              () => controller.transactions.isNotEmpty
              ? ListView.separated(
            itemCount: controller.transactions.length,
            //shrinkWrap: true,
            //physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: AppLayout.getHeight(25),
                  right: AppLayout.getHeight(25),
                ),
                child: TransactionTile(
                  transaction: controller.transactions[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              if (index % 2 == 0) {
                // return AppAdManager().getBannerAd();
              }else
              if(controller.transactions.length-1 == index){
                // return AppAdManager().getBannerAd();
              }
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
              const Gap(15),
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
  }
}
