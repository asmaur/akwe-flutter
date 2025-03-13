import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:poupey/src/constants/app_colors.dart';
import 'package:poupey/src/constants/app_layout.dart';
import 'package:poupey/src/models/marital_status.dart';
import 'package:poupey/src/models/user_sex.dart';
import 'package:poupey/src/pages/user_data/user_data_controller.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;

class UserDataPage extends StatelessWidget {
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserDataController>();
    final userDataFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appUserDataPageTitle.tr),
      ),
      body: Obx(() => controller.isLoading.value ? const Center(child:CircularProgressIndicator(color: AppColors.appDarkGreen,)) : SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Gap(AppLayout.getScreenHeight() * 0.01),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        //alignment: Alignment.center;
                        children: [
                          CircleAvatar(
                            radius: AppLayout.getHeight(50),
                            backgroundImage: controller.user?.photoURL != null
                                ? NetworkImage(controller.user?.photoURL ?? "")
                                : const AssetImage(
                                        "assets/images/urban-user-3.png")
                                    as ImageProvider,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(AppLayout.getHeight(10)),
                Text(
                  controller.user?.displayName ?? "",
                ),
                Gap(AppLayout.getHeight(2)),
                Text(
                  controller.user?.email ?? "",
                ),
                Gap(AppLayout.getHeight(5)),
                const Divider(),
              ],
            ),

            Form(
              key: userDataFormKey,
                child: Container(
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const Gap(10),

                        Text(translation.appUserDataMonthlyEarningText.tr),
                        Obx(() => Slider(
                          activeColor: AppColors.appBlue,
                          thumbColor: AppColors.appRed,
                          value: controller.monthlyEarning.value,
                          onChanged: (double? value) {
                            controller.monthlyEarning.value = value!;
                          },
                          divisions: 10,
                          label: "${controller.monthlyEarning.value}",
                          min: 0,
                          max: 10000,
                        ),),
                      ],
                    ),
                  ),
                  
                  const Divider(),
                  
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      controller: controller.firstName,
                      decoration: InputDecoration(
                        labelText: translation.appUserDataFirstName.tr,
                      ),
                      maxLines: 1,
                      maxLength: 50,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return translation.appTextFieldNameEmptyLabel.tr;
                        } else if (value.trim().length < 3) {
                          return translation.appTextFieldNameTooShortLabel.tr;
                        } else if (value.length > 50) {
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
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      controller: controller.lastName,
                      decoration: InputDecoration(
                        labelText: translation.appUserDataLastName.tr,
                      ),
                      maxLines: 1,
                      maxLength: 50,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return translation.appTextFieldNameEmptyLabel.tr;
                        } else if (value.trim().length < 3) {
                          return translation.appTextFieldNameTooShortLabel.tr;
                        } else if (value.length > 50) {
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
                  Container(
                    padding: EdgeInsets.only(
                      left: AppLayout.getHeight(10),
                      right: AppLayout.getHeight(10),
                    ),
                    width: AppLayout.getScreenWidth() * 0.9,
                    child: TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        labelText: translation.appUserDataEmail.tr,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          ValidationBuilder().email().maxLength(50).build(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: AppLayout.getHeight(10),
                      left: AppLayout.getHeight(10),
                      right: AppLayout.getHeight(10),
                    ),
                    width: AppLayout.getScreenWidth() * 0.9,
                    child: TextFormField(
                      controller: controller.dateInput,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.calendar_today),
                          //icon of text field
                          labelText: translation.appUserDataBirthdate.tr),
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
                  const Gap(5),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.only(
                  //         //left: AppLayout.getHeight(20),
                  //         right: AppLayout.getHeight(8),
                  //       ),
                  //       width: AppLayout.getScreenWidth() * 0.9,
                  //       child: DropdownButtonFormField<String>(
                  //         value: _controller.list.first,
                  //         elevation: 3,
                  //         onChanged: (String? value) {
                  //           // _controller.notifyDayBefore.value = value!;
                  //         },
                  //         decoration: InputDecoration(
                  //           labelText: "Sex",
                  //           // translation
                  //           //     .appPlanningNewPlanningReminderLabel.tr,
                  //           labelStyle:
                  //               TextStyle(fontSize: AppLayout.getHeight(10)),
                  //         ),
                  //         items: _controller.list
                  //             .map<DropdownMenuItem<String>>((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(
                  //               value,
                  //               style: TextStyle(
                  //                 fontSize: AppLayout.getHeight(12),
                  //               ),
                  //             ),
                  //           );
                  //         }).toList(),
                  //         validator: (value) {
                  //           if (value == null) {
                  //             return "";
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //     ),
                  //
                  //
                  //     Container(
                  //       padding: EdgeInsets.only(
                  //         right: AppLayout.getHeight(8),
                  //       ),
                  //       width: AppLayout.getScreenWidth() * 0.4,
                  //       child: DropdownButtonFormField<String>(
                  //         value: _controller.list.first,
                  //         elevation: 3,
                  //         onChanged: (String? value) {
                  //           // _controller.notifyDayBefore.value = value!;
                  //         },
                  //         decoration: InputDecoration(
                  //           labelText: "Gender",
                  //           // translation
                  //           //     .appPlanningNewPlanningReminderLabel.tr,
                  //           labelStyle:
                  //               TextStyle(fontSize: AppLayout.getHeight(10)),
                  //         ),
                  //         items: _controller.list
                  //             .map<DropdownMenuItem<String>>((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(
                  //               value,
                  //               style: TextStyle(
                  //                 fontSize: AppLayout.getHeight(12),
                  //               ),
                  //             ),
                  //           );
                  //         }).toList(),
                  //         validator: (value) {
                  //           if (value == null) {
                  //             return "";
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //     ),
                  //
                  //   ],
                  // ),

                  Container(
                    padding: EdgeInsets.only(
                      left: AppLayout.getHeight(10),
                      right: AppLayout.getHeight(10),
                    ),
                    width: AppLayout.getScreenWidth() * 0.9,
                    child: DropdownButtonFormField<UserSex>(
                      value: controller.selectedSex.value,
                      elevation: 3,
                      onChanged: (UserSex? value) {
                        controller.setSelectedSex(value!.key!);
                      },
                      decoration: InputDecoration(
                        labelText: translation.appUserDataSex.tr,
                        labelStyle:
                        const TextStyle(fontSize: 16),
                      ),
                      items: controller.sexList
                          .map<DropdownMenuItem<UserSex>>((UserSex sex) {
                        return DropdownMenuItem<UserSex>(
                          value: sex,
                          child: Text(
                            sex.name!,
                            style: TextStyle(
                              fontSize: AppLayout.getHeight(12),
                            ),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "";
                        }
                        return null;
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      left: AppLayout.getHeight(10),
                      right: AppLayout.getHeight(10),
                    ),
                    width: AppLayout.getScreenWidth() * 0.9,
                    child: DropdownButtonFormField<MaritalStatus>(
                      value: controller.selectedMarital.value,
                      elevation: 3,
                      onChanged: (MaritalStatus? value) {
                        controller.setSelectedMarital(value!.key!);
                      },
                      decoration: InputDecoration(
                        labelText: translation.appUserDataMaritalStatus.tr,
                        // translation
                        //     .appPlanningNewPlanningReminderLabel.tr,
                        labelStyle:
                            const TextStyle(fontSize: 16),
                      ),
                      items: controller.maritalStatus
                          .map<DropdownMenuItem<MaritalStatus>>((MaritalStatus marital) {
                        return DropdownMenuItem<MaritalStatus>(
                          value: marital,
                          child: Text(
                            marital.name!,
                            style: TextStyle(
                              fontSize: AppLayout.getHeight(12),
                            ),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "";
                        }
                        return null;
                      },
                    ),
                  ),

                  Gap(AppLayout.getHeight(20)),
                  
                  Column(
                    children: [
                      Text(translation.appUserDataChildren.tr),
                      Obx(() => Slider(
                        activeColor: AppColors.appBlue,
                        thumbColor: AppColors.appRed,
                        value: controller.children.value,
                        onChanged: (double? value) {
                          controller.children.value = value!;
                        },
                        divisions: 10,
                        label: "${controller.children.value}",
                        min: 0,
                        max: 10,
                      ),),
                    ],
                  ),
                  Gap(AppLayout.getHeight(10)),
                ],
              ),
            )),

            SizedBox(
              width: AppLayout.getWidth(150),
              child: OutlinedButton(
                child: Text(translation.appSaveButtonLabel.tr),
                onPressed: () {
                  if (userDataFormKey.currentState!.validate()) {
                    controller.updateUserProfile();
                  }
                },
              ),
            ),

            Gap(AppLayout.getHeight(40)),

            // email
            // first_name
            // last_name
            // cpf
            // sex
            // gender
            // birthdate
            // children
            // marital_status
            // monthly_earnings
            //is_premium_member
            //is_unlimited_member
            //has_support_contract
            //profession
          ],
        ),
      ),)
    );
  }
}
