import 'package:akwe/src/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';

class NextRoutine extends StatelessWidget {
  const NextRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.appMidGray,
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                child: Text(
                  translation.appNextRoutineTitle.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemBuilder: (_, index) {
                return Container(
                  child: Text(index.toString()),
                );
              },
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
