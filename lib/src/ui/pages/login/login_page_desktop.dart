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
import 'login_page_controller.dart';

class LoginPageDesktop extends StatelessWidget {
  LoginPageDesktop({super.key});

  final _controller = Get.find<LoginPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              children: [
                Gap(20),
                Center(
                  child: Container(
                    child: SvgPicture.asset(
                      height: 10.h,
                      width: 10.h,
                      "images/logos/akwe-logo.svg",
                      // colorFilter:
                      //     const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      // semanticsLabel: 'black white logo',
                    ),
                  ),
                ),
                Gap(30),
                Center(
                  child: Container(
                    child: Text(
                      translation.appMainSloganText.tr,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                Gap(30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Begin your journey",
                    //   style: Theme.of(context).textTheme.displaySmall,
                    // ),
                    Gap(20),
                    Text(
                      "Login in with Open Account",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GoogleAuthButton(
                            height: 8.h,
                            padding: EdgeInsets.all(2.h),
                            textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            onPressed: () {},
                            width:
                            _controller.authButtonStyle == null ? 30.w : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Divider(
                                color: Colors.black,
                                height: 10.sp,
                              )),
                        ),
                        Text("OR"),
                        Expanded(
                          child: new Container(
                            margin:
                            const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Divider(
                              color: Colors.black,
                              height: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Gap(20),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.h, right: 3.h),
                  child: Center(
                    child: ReactiveForm(
                      formGroup: _controller.loginForm,
                      child: Column(children: [
                        Gap(20),
                        ReactiveTextField(
                          formControlName: "email",
                          decoration: InputDecoration(
                            label: Text("Email"),
                            isDense: true,
                            prefixIcon: Icon(Icons.email_outlined, size: 16.sp,),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            contentPadding: EdgeInsets.all(2.h),
                            labelStyle: TextStyle(fontSize: 16.sp),
                            floatingLabelStyle: TextStyle(fontSize: 16.sp),
                          ),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Gap(20),
                        ReactiveTextField(
                          formControlName: "password",
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            label: Text("Password"),
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              size: 16.sp,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            contentPadding: EdgeInsets.all(3.h),
                            labelStyle: TextStyle(fontSize: 16.sp),
                            floatingLabelStyle: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                        Gap(60),
                        ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                fontSize: 12.sp, color: AppColors.appWhite,),
                          ),
                          style: ButtonStyle(
                            shape:
                            WidgetStateProperty.all(RoundedRectangleBorder()),
                            backgroundColor:
                            WidgetStatePropertyAll(AppColors.appDarkGreen),
                            fixedSize: WidgetStatePropertyAll(
                              Size(
                                  AppLayout.getWidth(40), AppLayout.getHeight(8)),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                Gap(30),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Do not have an account? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 12.sp),
                        ),
                        TextSpan(
                            text: 'Register here.',
                            style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.appDarkGreen,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.REGISTER);
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
