import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import '../../../constants/app_colors.dart';
import '../../../routes/app_pages.dart';
import 'register_page_controller.dart';

class RegisterPageMobile extends StatelessWidget {
  RegisterPageMobile({super.key});

  final _controller = Get.find<RegisterPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gap(10),
              Center(
                child: Container(
                  child: SvgPicture.asset(
                    height: 8.w,
                    width: 8.w,
                    "images/logos/akwe-logo.svg",
                    // colorFilter:
                    //     const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    // semanticsLabel: 'black white logo',
                  ),
                ),
              ),
              Gap(5),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      translation.appMainSloganText.tr,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Gap(10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   "Begin your journey",
                    //   style: Theme.of(context).textTheme.displaySmall,
                    // ),
                    Gap(10),
                    Text("Login in with Open Account"),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GoogleAuthButton(
                            height: 6.h,
                            onPressed: () {},
                            width:
                                _controller.authButtonStyle == null ? 350 : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black,
                                // height: 6.h,
                              )),
                        ),
                        Text("OR"),
                        Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              // height: 6.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Gap(20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: ReactiveForm(
                    formGroup: _controller.registerForm,
                    child: Column(children: [
                      // Gap(10),
                      ReactiveTextField(
                        formControlName: "name",
                        decoration: InputDecoration(
                          label: Text("name"),
                          prefixIcon: Icon(Icons.person_2_outlined),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                      Gap(10),
                      ReactiveTextField(
                        formControlName: "email",
                        decoration: InputDecoration(
                          label: Text("Email"),
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                      Gap(10),
                      // ReactiveTextField(
                      //   formControlName: "emailConfirmation",
                      //   decoration: InputDecoration(
                      //     label: Text("Email"),
                      //     prefixIcon: Icon(Icons.email_outlined),
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(),
                      //     ),
                      //   ),
                      // ),
                      Gap(10),
                      ReactiveTextField(
                        formControlName: "password",
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          label: Text("Password"),
                          prefixIcon: Icon(Icons.password_outlined),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                      Gap(10),
                      // ReactiveTextField(
                      //   formControlName: "password",
                      //   obscureText: true,
                      //   obscuringCharacter: "*",
                      //   decoration: InputDecoration(
                      //     label: Text("Password"),
                      //     prefixIcon: Icon(Icons.password_outlined),
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(),
                      //     ),
                      //   ),
                      // ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: (){
                          _controller.register();
                        },
                        child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all(RoundedRectangleBorder()),
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.appDarkGreen),
                          fixedSize: WidgetStatePropertyAll(
                            Size(60.w, 6.h),
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
                      TextSpan(text: "Already have an account? ", style: Theme.of(context).textTheme.bodySmall,),
                      TextSpan(
                          text: 'Login here.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
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
