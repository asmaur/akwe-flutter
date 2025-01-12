import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/pages/home/home_controller.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:akwe/src/ui/widgets/components/balance_card.dart';
import 'package:akwe/src/ui/widgets/components/expense_tile.dart';
import 'package:akwe/src/ui/widgets/components/income_tile.dart';
import 'package:akwe/src/ui/widgets/components/month_budget.dart';
import 'package:akwe/src/ui/widgets/components/next_routine.dart';
import 'package:akwe/src/ui/widgets/components/saving_goal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class HomeViewMobilePortrait extends StatelessWidget {
  HomeViewMobilePortrait({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Dashboard",
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                onPressed: () {},
                icon: Badge(
                  child: Icon(
                    Icons.notifications_outlined,
                  ),
                  label: Text("2"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ]),
      drawer: AppDrawerMobile(),
      body: Obx(() => RefreshIndicator(
        onRefresh: () => controller.refreshMyBudget(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BalanceCard(budget: controller.budget.value,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IncomeTile(budget: controller.budget.value),
                    ExpenseTile(budget: controller.budget.value),
                  ],
                ),
                MonthBudget(budget: controller.budget.value),
                SavingGoal(),
                // NextRoutine(),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }
}
