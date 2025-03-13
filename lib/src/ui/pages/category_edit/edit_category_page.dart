import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/shared/color_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';
import 'edit_category_page_controller.dart';

class EditCategoryPage extends StatelessWidget {
  const EditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditCategoryPageController controller =
        Get.find<EditCategoryPageController>();
    final editCategoryFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.userCategoryEditTitle.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ReactiveForm(
                formGroup: controller.form,
                child: Column(
                  children: [
                    SizedBox(
                      // width: AppLayout.getScreenWidth() * 0.9,
                      child: ReactiveTextField(
                        formControlName: "name",
                        decoration: InputDecoration(
                          labelText: translation.appTextFieldNameLabel.tr,
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              translation.userCategoryErrorCategoryNameEmpty.tr,
                          ValidationMessage.minLength: (_) => translation
                              .userCategoryErrorCategoryNameLength.tr,
                        },
                      ),

                      // TextFormField(
                      //   controller: controller.name,
                      //   decoration: InputDecoration(
                      //     labelText: translation.appTextFieldNameLabel.tr,
                      //   ),
                      //   maxLength: 20,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return translation.userCategoryErrorCategoryNameEmpty.tr;
                      //     } else if (value.length < 5) {
                      //       return translation.userCategoryErrorCategoryNameLength.tr;
                      //     }
                      //     return null;
                      //   },
                      // ),
                    ),
                    const Gap(10),

                    Container(
                      child: ReactiveSwitchListTile(
                        formControlName: "income",
                        // leading: const Icon(Icons.info_outline_rounded),
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Icon(Icons.info_outline_rounded),
                            ),
                            Text(
                              translation.userCategoryIsIncomeLabel.tr,
                            ),
                          ],
                        ),
                      ),

                      // Obx(
                      //   () => ListTile(
                      //     leading: const Icon(Icons.info_outline_rounded),
                      //     title: Text(
                      //       translation.userCategoryIsIncomeLabel.tr,
                      //     ),
                      //     enabled: true,
                      //     onTap: () => controller.toggle(),
                      //     //enableFeedback: true;
                      //     trailing: Switch(
                      //       onChanged: (value) => controller.toggle(),
                      //       value: controller.income.value,
                      //     ),
                      //   ),
                      // ),
                    ),

                    const Divider(),

                    Obx(
                      () => ListTile(
                        leading: const Icon(Icons.image),
                        title: Text(
                          translation.appSelectIconLabel.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: controller.selectedColor.value.color,
                              borderRadius: BorderRadius.circular(50)),
                          width: 35,
                          height: 35,
                          child: Icon(
                            controller.selectedIcon.value.icon,
                            color: AppColors.appWhite,
                            size: 24,
                          ),
                        ),
                        onTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          showDragHandle: true,
                          context: context,
                          builder: (context) => loadIconSheet(controller),
                        ),
                      ),
                    ),

                    const Divider(),

                    Obx(
                      () => ListTile(
                        leading: const Icon(Icons.palette_outlined),
                        title: Text(translation.appSelectColorLabel.tr),
                        trailing: ColorTile(controller.selectedColor.value),
                        enabled: true,
                        enableFeedback: true,
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: AppLayout.getScreenHeight() * .5,
                                padding:
                                    EdgeInsets.all(AppLayout.getHeight(16)),
                                //color: Colors.white,
                                decoration: const BoxDecoration(
                                  color: AppColors.appMidGray,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.app_color_list.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: AppLayout.getHeight(8)),
                                      child: Column(
                                        children: <Widget>[
                                          //ColorTile();
                                          Obx(
                                            () => FloatingActionButton(
                                              mini: true,
                                              onPressed: () {
                                                controller
                                                    .updateSelectedColor(index);
                                                Get.back();
                                              },
                                              //child: Icon(Icons.done, color: index == controller.selectedIndex.value ? Colors.white:colorsData.elementAt(index),size: 28),
                                              //child: Icon(Icons.done; colo appDataColors.elementAt(index); size: 20);
                                              backgroundColor: controller
                                                  .app_color_list
                                                  .elementAt(index)
                                                  .color,
                                              elevation: 0.0,
                                              heroTag: null,
                                              child: controller.selectedIndex
                                                          .value ==
                                                      index
                                                  ? const Icon(Icons.done,
                                                      color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                ),

                                // container end
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const Divider(),

                    //Gap(10),
                    SizedBox(
                      // width: AppLayout.getScreenWidth() * 0.9,
                      child: ReactiveTextField(
                        formControlName: "description",
                        decoration: InputDecoration(
                            labelText:
                                translation.appTextFieldDescriptionLabel.tr),
                        maxLength: 50,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: AppLayout.getScreenWidth() * 0.7,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.appRed)),
                    child: Text(
                      translation.appCancelButtonLabel.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.appRed),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // if (newCategoryFormKey.currentState!.validate()) {
                      controller.updateCategory();
                      // }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.appRed,
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    child: Text(
                      translation.appSaveButtonLabel.tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.appWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    //         (Set<MaterialState> states) {
                    //       if (states.contains(MaterialState.pressed)) {
                    //         return AppColors.appRed;
                    //       }
                    //       return AppColors.appRed;
                    //     },
                    //   ),
                    //   shape: MaterialStateProperty.all(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //       side: const BorderSide(color: AppColors.appRed, width: 0)
                    //     )
                    //   )
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadIconSheet(EditCategoryPageController controller) {
    return Container(
      height: AppLayout.getScreenHeight() * .5,
      padding: EdgeInsets.all(AppLayout.getHeight(16)),
      //color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white, //Theme.of(Get.context!).colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.app_icon_list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: AppLayout.getHeight(8)),
            child: Column(
              children: <Widget>[
                //ColorTile();
                Obx(
                  () => FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      controller.updateSelectedIcon(index);
                      Get.back();
                    },
                    //child: Icon(Icons.done, color: index == controller.selectedIndex.value ? Colors.white:colorsData.elementAt(index),size: 28),
                    //child: Icon(Icons.done; colo appDataColors.elementAt(index); size: 20);
                    backgroundColor: controller.selectedIconIndex.value == index
                        ? controller.selectedColor.value.color
                        : Colors.black54,
                    elevation: 0.0,
                    heroTag: null,
                    child: Icon(
                      controller.app_icon_list.elementAt(index).icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        shrinkWrap: true,
      ),

      // container end
    );
  }
}
