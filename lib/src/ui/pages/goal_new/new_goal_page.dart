import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/ui/pages/goal_new/new_goal_page_controller.dart';
import 'package:akwe/src/ui/shared/color_tile.dart';
import 'package:akwe/src/utils/app_icon_list.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NewGoalPage extends StatelessWidget {
  NewGoalPage({super.key});

  // FormGroup buildForm() => fb.group(<String, Object>{
  //       'amount': FormControl<int>(),
  //       'name': FormControl<String>(
  //         validators: [Validators.required],
  //       ),
  //     'category': FormControl<int>(validators: [Validators.required]),
  //     'deadline': FormControl<DateTime>(validators: [Validators.required]),
  //     'icon': FormControl<int>(validators: [Validators.required]),
  //     'color': FormControl<int>(validators: [Validators.required]),
  //   'date': FormControl<DateTime>(value: null),
  //     });

  final controller = Get.find<NewGoalPageController>();
  final newGoalFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translation.appGoalCreateGoalTitle.tr,
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReactiveForm(
                formGroup: controller.form,
                // builder: (context, form, child) {
                  // return
                   child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Gap(AppLayout.getHeight(20)),
                      Form(
                        key: newGoalFormKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppLayout.getHeight(10),
                                  horizontal: AppLayout.getHeight(20)),
                              child: ReactiveTextField(
                                formControlName: "target_amount",

                                decoration: InputDecoration(
                                  label:
                                  Text(translation.appGoalTargetAmount.tr),
                                  hintText: translation.appGoalTargetAmount.tr,
                                  //translation.userAccountAccountBalanceText.tr,
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    fontSize: AppLayout.getHeight(30)),
                                keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  CurrencyInputFormatter(
                                    thousandSeparator: ThousandSeparator.Space,
                                    mantissaLength: 2,
                                  )
                                ],
                                validationMessages: {
                                  ValidationMessage.required: (_) => translation.appTextFieldAmountEmptyLabel.tr
                                },
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return translation
                                //         .appTextFieldAmountEmptyLabel.tr;
                                //   } else if (double.tryParse(
                                //       value.removeAllWhitespace)! <=
                                //       0) {
                                //     return translation
                                //         .appTextFieldAmountNullLabel.tr;
                                //   }
                                //   return null;
                                // },
                              ),


                              // TextFormField(
                              //     controller: controller.amount,
                              //     decoration: InputDecoration(
                              //       label:
                              //           Text(translation.appGoalTargetAmount.tr),
                              //       hintText: translation.appGoalTargetAmount.tr,
                              //       //translation.userAccountAccountBalanceText.tr,
                              //       border: InputBorder.none,
                              //     ),
                              //     style: TextStyle(
                              //         fontSize: AppLayout.getHeight(30)),
                              //     keyboardType:
                              //         const TextInputType.numberWithOptions(
                              //             decimal: true),
                              //     inputFormatters: <TextInputFormatter>[
                              //       CurrencyInputFormatter(
                              //         thousandSeparator: ThousandSeparator.Space,
                              //         mantissaLength: 2,
                              //       )
                              //     ],
                              //     validator: (value) {
                              //       if (value!.isEmpty) {
                              //         return translation
                              //             .appTextFieldAmountEmptyLabel.tr;
                              //       } else if (double.tryParse(
                              //               value.removeAllWhitespace)! <=
                              //           0) {
                              //         return translation
                              //             .appTextFieldAmountNullLabel.tr;
                              //       }
                              //       return null;
                              //     },
                              // ),
                            ),

                            // ListTile(
                            //   leading: const Icon(Icons.pin_drop_outlined),
                            //   title: TextFormField(
                            //     controller: controller.goalName,
                            //     decoration: InputDecoration(
                            //       labelText: translation.appGoalGoalNameText.tr,
                            //     ),
                            //     maxLines: 1,
                            //     maxLength: 30,
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         return translation.appTextFieldNameEmptyLabel.tr;
                            //       } else if (value.trim().length < 5) {
                            //         return translation.appTextFieldNameTooShortLabel.tr;
                            //       } else if (value.length > 29) {
                            //         return translation.appTextFieldNameTooLongLabel.tr;
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                            ListTile(
                              leading: const Icon(Icons.pin_drop_outlined),
                              title: ReactiveTextField<String>(
                                formControlName: 'name',
                                maxLines: 1,
                                maxLength: 5,
                                validationMessages: {
                                  ValidationMessage.required: (_) =>
                                  'The email must not be empty',
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Goal name',
                                  helperText: '',
                                  helperStyle: TextStyle(height: 0.7),
                                  errorStyle: TextStyle(height: 0.7),
                                ),
                              ),



                              // TextFormField(
                              //   controller: controller.goalName,
                              //   decoration: InputDecoration(
                              //     labelText: translation.appGoalGoalNameText.tr,
                              //   ),
                              //   maxLines: 1,
                              //   maxLength: 30,
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return translation
                              //           .appTextFieldNameEmptyLabel.tr;
                              //     } else if (value.trim().length < 5) {
                              //       return translation
                              //           .appTextFieldNameTooShortLabel.tr;
                              //     } else if (value.length > 29) {
                              //       return translation
                              //           .appTextFieldNameTooLongLabel.tr;
                              //     }
                              //     return null;
                              //   },
                              // ),
                            ),



                            ReactiveDateTimePicker(
                              formControlName: 'deadline_date',
                              firstDate: DateTime(DateTime.now().year),
                              valueAccessor: DateTimeValueAccessor(
                                dateTimeFormat: DateFormat("dd MMM yyyy")
                              ),
                              decoration: InputDecoration(
                                labelText: translation.appGoalDeadlineDateLabel.tr,
                                // border: OutlineInputBorder(),
                                helperText: '',
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                            ),


                            Obx(() =>ReactiveDropdownField<String>(
                              formControlName: 'category_id',
                              hint: Text(translation.appTextFieldCategoryLabel.tr),
                              items: controller.categories
                                  .map<DropdownMenuItem<String>>(
                                      (AppCategory el) {
                                    return DropdownMenuItem<String>(
                                      value: el.id,
                                      child: Text(el.name!),
                                    );
                                  }).toList(),
                            ),),




                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.only(
                            //           left: AppLayout.getHeight(10)),
                            //       child: Text(
                            //           translation.appTextFieldCategoryLabel.tr),
                            //     ),
                            //     Container(
                            //       padding:
                            //           EdgeInsets.all(AppLayout.getHeight(10)),
                            //       //width: AppLayout.getScreenWidth() * 0.45,
                            //       child: Obx(
                            //         () => DropdownButtonFormField<String>(
                            //           decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                 color: Theme.of(context).brightness ==
                            //                         Brightness.light
                            //                     ? Colors.black
                            //                     : Colors.white,
                            //                 width: 2,
                            //               ),
                            //               borderRadius: BorderRadius.circular(10),
                            //             ),
                            //             border: OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                 color: Theme.of(context).brightness ==
                            //                         Brightness.light
                            //                     ? Colors.black
                            //                     : Colors.white,
                            //                 width: 2,
                            //               ),
                            //               borderRadius: BorderRadius.circular(10),
                            //             ),
                            //             // filled: true;
                            //             // fillColor: Colors.blueAccent;
                            //           ),
                            //           validator: (value) => value == null
                            //               ? translation
                            //                   .appTextFieldEmptyCategoryLabel.tr
                            //               : null,
                            //           //dropdownColor: Colors.blueAccent;
                            //           value: controller.selectedCategory.value,
                            //           onChanged: (value) {
                            //             controller.updateCategory(value!);
                            //           },
                            //           items: controller.categories
                            //               .map<DropdownMenuItem<String>>(
                            //                   (AppCategory el) {
                            //             return DropdownMenuItem<String>(
                            //               value: el.id,
                            //               child: Text(el.name!),
                            //             );
                            //           }).toList(),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // Container(
                            //   padding: EdgeInsets.only(
                            //     top: AppLayout.getHeight(5),
                            //     left: AppLayout.getHeight(10),
                            //     right: AppLayout.getHeight(10),
                            //   ),
                            //   child: TextFormField(
                            //     controller: controller.dateInput,
                            //     decoration: InputDecoration(
                            //       icon: const Icon(Icons.calendar_today),
                            //       //icon of text field
                            //       labelText:
                            //           translation.appGoalDeadlineDateLabel.tr,
                            //     ),
                            //     readOnly: true,
                            //     onTap: () async {
                            //       controller.chooseDate();
                            //     },
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         return translation
                            //             .appTransactionNewTransactionDateEmptyLabel
                            //             .tr;
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Gap(AppLayout.getHeight(20)),
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
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ReactiveTextField(
                          formControlName: "description",
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            // border: OutlineInputBorder(),
                            helperText: '',
                            prefixIcon: Icon(Icons.edit),
                          ),
                        ),
                      ),

                      // const Divider(),
                      Container(
                        width: AppLayout.getScreenWidth() * 0.7,
                        padding: EdgeInsets.only(
                          top: AppLayout.getHeight(20),
                          bottom: AppLayout.getHeight(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                  side:
                                      const BorderSide(color: AppColors.appRed)),
                              child: Text(
                                translation.appCancelButtonLabel.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: AppColors.appRed),
                              ),
                            ),
                            // ReactiveFormConsumer(builder: (context, form, child){
                              // return
                                OutlinedButton(
                              onPressed: () => controller.testSavedForm(),
                              // form.valid ? () {
                              //   // if (newGoalFormKey.currentState!.validate()) {
                              //     controller.testSavedForm();
                              //   // }
                              // } : null,
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.appRed,
                                  side: const BorderSide(
                                      color: Colors.transparent)),
                              child: Text(
                                translation.appSaveButtonLabel.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: AppColors.appWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            )
                              // },
                            // )
                          ],
                        ),
                      ),
                    ],
                  )
                // }
                ),
          ),
        ));
  }

  loadIconSheet(NewGoalPageController controller) {
    final appIcons = getAppIconList();
    return Container(
      height: AppLayout.getScreenHeight() * .5,
      padding: EdgeInsets.all(AppLayout.getHeight(16)),
      //color: Colors.white,
      decoration: const BoxDecoration(
        color:
            Colors.white, //Theme.of(Get.context!).brightness.name == "dark" ? ,
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
    );
  }
}
