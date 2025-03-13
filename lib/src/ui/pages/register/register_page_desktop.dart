import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_layout.dart';
import '../../../routes/app_pages.dart';
import 'register_page_controller.dart';

class RegisterPageDesktop extends StatelessWidget {
  RegisterPageDesktop({super.key});

  final _controller = Get.find<RegisterPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          height: 10.h,
                          width: 10.h,
                          "images/logos/akwe-logo.svg",
                        ),
                      ),
                      Gap(20),
                      Container(
                        child: Text(
                          translation.appMainSloganText.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 16.sp),
                        ),
                      ),
                      Gap(20),
                      Text(
                        "Begin your journey",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Register with open accounts",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                              ),
                              Gap(20),
                              GoogleAuthButton(
                                height: 8.h,
                                width: _controller.authButtonStyle == null
                                    ? 25.w
                                    : null,
                                darkMode: Theme.of(context).brightness ==
                                    Brightness.dark,
                                // text: "Login with Google",
                                padding: EdgeInsets.all(2.h),
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                      height: 50.h,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: VerticalDivider(
                          color: AppColors.appDarkGreen,
                          thickness: 1,
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Register with email",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                              ),
                              Gap(20),
                              Padding(
                                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                child: Center(
                                  child: ReactiveForm(
                                    formGroup: _controller.registerForm,
                                    child: Column(
                                      children: [
                                        // Gap(20),
                                        ReactiveTextField(
                                          formControlName: "name",
                                          decoration: InputDecoration(
                                            label: Text("name"),
                                            prefixIcon:
                                                Icon(Icons.person_2_outlined),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            contentPadding: EdgeInsets.all(2.h),
                                            labelStyle:
                                                TextStyle(fontSize: 16.sp),
                                            floatingLabelStyle:
                                                TextStyle(fontSize: 16.sp),
                                          ),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Gap(20),
                                        ReactiveTextField(
                                          formControlName: "email",
                                          decoration: InputDecoration(
                                            label: Text("Email"),
                                            isDense: true,
                                            prefixIcon:
                                                Icon(Icons.email_outlined),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            contentPadding: EdgeInsets.all(2.h),
                                            labelStyle:
                                                TextStyle(fontSize: 16.sp),
                                            floatingLabelStyle:
                                                TextStyle(fontSize: 16.sp),
                                          ),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Gap(15),
                                        ReactiveTextField(
                                          formControlName: "password",
                                          obscureText: true,
                                          obscuringCharacter: "*",
                                          decoration: InputDecoration(
                                            label: Text("Password"),
                                            isDense: true,
                                            prefixIcon:
                                                Icon(Icons.password_outlined),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            contentPadding: EdgeInsets.all(3.h),
                                            labelStyle:
                                                TextStyle(fontSize: 16.sp),
                                            floatingLabelStyle:
                                                TextStyle(fontSize: 16.sp),
                                          ),
                                        ),
                                        Gap(40),
                                        ElevatedButton(
                                          onPressed: () {
                                            _controller.register();
                                          },
                                          child: Text(
                                            "Register",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                    fontSize: 16.sp,
                                                    color: AppColors.appWhite,),
                                          ),
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder()),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    AppColors.appDarkGreen,),
                                            fixedSize: WidgetStatePropertyAll(
                                              Size(AppLayout.getWidth(30),
                                                  AppLayout.getHeight(8)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16.sp),
                        ),
                        TextSpan(
                            text: 'Login here.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.appDarkGreen,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.LOGIN);
                              }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
