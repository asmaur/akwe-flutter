import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SavingGoal extends StatelessWidget {
  const SavingGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 95.w, //AppLayout.getScreenWidth() * 0.95,
            height: AppLayout.getHeight(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translation.appSavingGoalTitle.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                          // fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translation.appSavingGoalSubTitle.tr,
                        style:
                        Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.appGreen,
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.sackDollar,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
