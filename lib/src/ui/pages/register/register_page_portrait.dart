import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import '../../../constants/app_colors.dart';
import 'register_page_controller.dart';

class RegisterPagePortrait extends StatelessWidget {
  RegisterPagePortrait({super.key});

  final _controller = Get.find<RegisterPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),
              Center(
                child: Container(
                  child: SvgPicture.asset(
                    height: 12.h,
                    width: 12.h,
                    "images/logos/akwe-logo.svg",
                    // colorFilter:
                    //     const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    // semanticsLabel: 'black white logo',
                  ),
                ),
              ),
              Gap(40),
              Center(
                child: Container(
                  child: Text(
                    translation.appMainSloganText.tr,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.sp,
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
                  Gap(50),
                  Text(
                    "Login in with Open Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: GoogleAuthButton(
                          height: 6.h,
                          width:
                          _controller.authButtonStyle == null ? 50.w : null,
                          onPressed: () {},
                          padding: EdgeInsets.all(2.h),
                          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                              height: 36.sp,
                            )),
                      ),
                      Text("OR"),
                      Expanded(
                        child: new Container(
                          margin:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36.sp,
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
                    formGroup: _controller.registerForm,
                    child: Column(children: [
                      // Gap(20),
                      ReactiveTextField(
                        formControlName: "name",
                        decoration: InputDecoration(
                          label: Text("name"),
                          prefixIcon: Icon(Icons.person_2_outlined),
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
                      Gap(40),
                      ElevatedButton(
                        onPressed: (){
                          _controller.register();
                        },
                        child: Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  fontSize: 16.sp, color: AppColors.appWhite),
                        ),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all(RoundedRectangleBorder()),
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.appDarkGreen),
                          fixedSize: WidgetStatePropertyAll(
                            Size(
                                AppLayout.getWidth(40), AppLayout.getHeight(5)),
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
                        text: "Already have an account? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 16.sp),
                      ),
                      TextSpan(
                          text: 'Login here.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
    );
  }
}
