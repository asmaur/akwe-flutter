import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:akwe/src/ui/widgets/components/balance_card.dart';
import 'package:akwe/src/ui/widgets/components/month_budget.dart';
import 'package:akwe/src/ui/widgets/components/next_routine.dart';
import 'package:akwe/src/ui/widgets/components/saving_goal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class HomeViewMobilePortrait extends StatelessWidget {
  const HomeViewMobilePortrait({super.key});

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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 5),
            () {},
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BalanceCard(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: AppLayout.getScreenWidth() * .45,
                        height: AppLayout.getHeight(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.appLightBlue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              margin: EdgeInsets.only(
                                top: 16,
                                right: 38,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appDarkGreen,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.trending_up_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      "R\$ 15.000,89",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      translation.appPerformanceIncomeLabel.tr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: AppLayout.getScreenWidth() * .43,
                        height: AppLayout.getHeight(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.appLightRose,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              margin: EdgeInsets.only(
                                top: 16,
                                right: 38,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appRose,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.trending_down_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      "R\$ 15.000,89",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      translation.appPerformanceExpenseLabel.tr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                MonthBudget(),
                SavingGoal(),
                NextRoutine(),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
