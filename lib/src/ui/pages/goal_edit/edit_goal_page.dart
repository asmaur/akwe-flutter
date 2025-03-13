import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/ui/shared/color_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';

import 'edit_goal_page_controller.dart';

class EditGoalPage extends StatelessWidget {
  EditGoalPage({super.key});

  final newGoalFormKey = GlobalKey<FormState>();
  final controller = Get.find<EditGoalPageController>();

  final locale = Get.deviceLocale;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.appEditGoalTitle.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
        ),
      ),
      body: ListView(children: [
        Gap(AppLayout.getHeight(20)),

        Container(
          padding: EdgeInsets.symmetric(
              vertical: AppLayout.getHeight(10),
              horizontal: AppLayout.getHeight(20)),
          child: TextFormField(
            controller: controller.amount,
            decoration: InputDecoration(
              label: Text(translation.appGoalTargetAmount.tr),
              hintText: translation.appGoalTargetAmount.tr,
              //translation.userAccountAccountBalanceText.tr,
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: AppLayout.getHeight(30)),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              CurrencyInputFormatter(
                thousandSeparator: ThousandSeparator.Space,
                mantissaLength: 2,
              )
            ],
          ),
        ),

        ListTile(
          title: Text(translation.appGoalArchivedValueLabel.tr),
          trailing: Text(
            currency.format(controller.currentGoal.value.balance),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),

        Form(
          key: newGoalFormKey,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.pin_drop_outlined),
                title: TextFormField(
                  controller: controller.goalName,
                  decoration: InputDecoration(
                      labelText: translation.appGoalGoalNameText.tr,
                      ),
                  maxLines: 1,
                  maxLength: 30,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return translation.appTextFieldNameEmptyLabel.tr;
                    } else if (value.trim().length < 5) {
                      return translation.appTextFieldNameTooShortLabel.tr;
                    } else if (value.length > 29) {
                      return translation.appTextFieldNameTooLongLabel.tr;
                    }
                    return null;
                  },
                ),
                // trailing: Icon(Icons.arrow_forward_ios);
                // enabled: true;
                // onTap: () {
                //   showModalBottomSheet<dynamic>(
                //       isScrollControlled: true;
                //       context: context;
                //       builder: (context) {
                //         return Container(
                //           height: AppLayout.getScreenHeight() * .7;
                //           child: Column(
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.only(left: 20; top: 5; );
                //                 child: Center(
                //                   child: Row(
                //                     children: [
                //                       SizedBox(
                //                         width: AppLayout.getWidth(300);
                //                         child: TextFormField();
                //                       );
                //                       IconButton(onPressed: (){}; icon: Icon(Icons.send);)
                //                     ];
                //                   );
                //                 );
                //               );
                //               Divider(color: AppColors.appBlue;);
                //               Expanded(
                //                 child: ListView(
                //                   children: [
                //                     CheckboxListTile(
                //                       title: Text("Wallet");
                //                       controlAffinity:
                //                       ListTileControlAffinity.platform;
                //                       secondary: Icon(Icons.credit_card_outlined);
                //                       //activeColor: Colors.black54;
                //                       //checkColor: Colors.orange;
                //                       checkboxShape: RoundedRectangleBorder(
                //                           borderRadius:
                //                           BorderRadius.circular(10));
                //                       value: false;
                //                       onChanged: (value) {};
                //                     );
                //                     CheckboxListTile(
                //                       title: Text("Credit card");
                //                       controlAffinity:
                //                       ListTileControlAffinity.platform;
                //                       secondary: Icon(Icons.credit_card);
                //                       //activeColor: Colors.black54;
                //                       //checkColor: Colors.orange;
                //                       checkboxShape: RoundedRectangleBorder(
                //                           borderRadius:
                //                           BorderRadius.circular(10));
                //                       value: false;
                //                       onChanged: (value) {};
                //                     );
                //                     CheckboxListTile(
                //                       title: Text("Savings");
                //                       controlAffinity:
                //                       ListTileControlAffinity.platform;
                //                       secondary: Icon(Icons.savings);
                //                       //activeColor: Colors.black54;
                //                       //checkColor: Colors.orange;
                //                       checkboxShape: RoundedRectangleBorder(
                //                           borderRadius:
                //                           BorderRadius.circular(10));
                //                       value: false;
                //                       onChanged: (value) {};
                //                     );
                //                     CheckboxListTile(
                //                       title: Text("Investimentos");
                //                       controlAffinity:
                //                       ListTileControlAffinity.platform;
                //                       secondary: Icon(Icons.candlestick_chart_outlined);
                //                       //activeColor: Colors.black54;
                //                       //checkColor: Colors.orange;
                //                       checkboxShape: RoundedRectangleBorder(
                //                           borderRadius:
                //                           BorderRadius.circular(10));
                //                       value: false;
                //                       onChanged: (value) {};
                //                     );
                //                     CheckboxListTile(
                //                       title: Text("Reservas");
                //                       controlAffinity:
                //                       ListTileControlAffinity.platform;
                //                       secondary: Icon(Icons.border_all_outlined);
                //                       //activeColor: Colors.black54;
                //                       //checkColor: Colors.orange;
                //                       checkboxShape: RoundedRectangleBorder(
                //                           borderRadius:
                //                           BorderRadius.circular(10));
                //                       value: false;
                //                       onChanged: (value) {};
                //                     );
                //                   ];
                //                 );
                //               )
                //             ];
                //           );
                //         );
                //       });
                // };
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: AppLayout.getHeight(10)),
                    child: Text(translation.appTextFieldCategoryLabel.tr),
                  ),
                  Container(
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
                    //width: AppLayout.getScreenWidth() * 0.45,
                    child: Obx(() =>ReactiveDropdownField<String>(
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
                    // Obx(
                    //       () => DropdownButtonFormField<int>(
                    //     decoration: InputDecoration(
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Theme.of(context).brightness ==
                    //               Brightness.light
                    //               ? Colors.black
                    //               : Colors.white,
                    //           width: 2,
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Theme.of(context).brightness ==
                    //               Brightness.light
                    //               ? Colors.black
                    //               : Colors.white,
                    //           width: 2,
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       // filled: true;
                    //       // fillColor: Colors.blueAccent;
                    //     ),
                    //     validator: (value) => value == null
                    //         ? translation.appTextFieldEmptyCategoryLabel.tr
                    //         : null,
                    //     //dropdownColor: Colors.blueAccent;
                    //     value: controller.selectedCategory.value.id,
                    //     onChanged: (value) {
                    //       controller.updateCategory(value!);
                    //     },
                    //     items: controller.categories
                    //         .map<DropdownMenuItem<int>>((AppCategory el) {
                    //       return DropdownMenuItem<int>(
                    //         value: el.id,
                    //         child: Text(el.name!),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),

        //Divider(),

        Container(
          padding: EdgeInsets.only(
            top: AppLayout.getHeight(5),
            left: AppLayout.getHeight(10),
            right: AppLayout.getHeight(10),
          ),
          child: TextFormField(
            controller: controller.dateInput,
            decoration: InputDecoration(
              icon: const Icon(Icons.calendar_today),
              //icon of text field
              labelText:
                  translation.appGoalDeadlineDateLabel.tr,
            ),
            readOnly: true,
            onTap: () async {
              controller.chooseDate();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return translation
                    .appTransactionNewTransactionDateEmptyLabel.tr;
              }
              return null;
            },
          ),
        ),

        Gap(AppLayout.getHeight(20)),

        Obx(
          () => ListTile(
            // leading: SizedBox(
            //   width: 40,
            //   height: 40,
            //   child: Image.asset(
            //     _controller.selectedIcon.value.icon!,
            //     fit: BoxFit.contain,
            //   ),
            // ),

            // Container(
            //   //margin: EdgeInsets.all(10),
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     //shape: BoxShape.circle,
            //     borderRadius: BorderRadius.circular(50),
            //     border: Border.all(color: Colors.black),
            //     image: DecorationImage(
            //       image: AssetImage(controller.selectedBank.value.logo!
            //           //"assets/banks/Banco_Do_Brasil_logo_PNG6.png"
            //           ),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
            // Container(
            //   width: 95,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ColorTile(_controller.selectedColor.value),
            //       // IconButton(
            //       //   onPressed: () {},
            //       //   icon: Icon(Icons.arrow_forward_ios_outlined),
            //       // ),
            //     ],
            //   ),
            // ),
            enabled: true,
            enableFeedback: true,
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: AppLayout.getScreenHeight() * .5,
                    padding: EdgeInsets.all(AppLayout.getHeight(16)),
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
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(right: AppLayout.getHeight(8)),
                          child: Column(
                            children: <Widget>[
                              //ColorTile();
                              Obx(
                                () => FloatingActionButton(
                                  mini: true,
                                  onPressed: () {
                                    controller.updateSelectedColor(index);
                                    Get.back();
                                  },
                                  //child: Icon(Icons.done, color: index == controller.selectedIndex.value ? Colors.white:colorsData.elementAt(index),size: 28),
                                  //child: Icon(Icons.done; colo appDataColors.elementAt(index); size: 20);
                                  backgroundColor: controller.app_color_list
                                      .elementAt(index)
                                      .color,
                                  elevation: 0.0,
                                  heroTag: null,
                                  child: controller.selectedIndex.value ==
                                          index
                                      ? const Icon(Icons.done, color: Colors.white)
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
                  if (newGoalFormKey.currentState!.validate()) {
                    controller.updateNewGoal();
                  }
                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.appRed,
                    side: const BorderSide(color: Colors.transparent)),
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
      ]),
    );
  }

  loadIconSheet(EditGoalPageController controller) {
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
                    backgroundColor:
                        controller.selectedIconIndex.value == index
                            ? controller.selectedColor.value.color
                            : Colors.black54,
                    elevation: 0.0,
                    heroTag: null,
                    child:
                        Icon(controller.app_icon_list.elementAt(index).icon, color: Colors.white,),
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
