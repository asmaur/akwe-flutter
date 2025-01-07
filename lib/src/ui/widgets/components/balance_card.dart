import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.appDarkGreen,
        elevation: 5,
        child: Container(
          width: AppLayout.getScreenWidth() * 0.95,
          height: AppLayout.getHeight(200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.purpleAccent,
                width: (AppLayout.getScreenWidth() * 0.95) * 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              translation.appHomeMainBudgetText.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppColors.appGray,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 250,
                              // color: Colors.yellow,
                              child: Text(
                                "R\$ 1.500.660,87",
                                style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appWhite,
                                  fontFamily: GoogleFonts.raleway()
                                      .fontFamily,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            translation.userBudgetDetailTitle.tr,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.lightBlue,
                width: (AppLayout.getScreenWidth() * 0.95) * 0.35,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.appWhite,
                            ),
                            child: Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appYellow,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 108,
                            width: 200,
                            child: Image.asset(
                              "assets/images/group-36.png",
                              fit: BoxFit.cover,
                              // height: 100,
                              // width: 180,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
