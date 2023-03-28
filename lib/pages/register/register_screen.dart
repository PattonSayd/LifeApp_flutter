import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/register/register_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';

import '../../localization/languages/languages.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 57.ch),
                        Image.asset(Assets.logo),
                        SizedBox(height: 32.ch),
                        Text(
                          Languages.of(context)!.signup,
                          style: TextStyle(
                            fontSize: 34.csp,
                            height: 41.ch / 34.csp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 40.ch),
                        CustomTextField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            hint: Languages.of(context)!.nameAndSurname,
                            hintStyle: TextStyle(
                              fontSize: 17.csp,
                              fontWeight: FontWeight.w400,
                              height: 22.ch / 17.csp,
                              color: CustomColors.tertiaryLight,
                            ),
                            hasBorder: true,
                            padding: EdgeInsets.only(bottom: 19.ch, left: 10),
                            errorText:
                                registerController.registerError.value?.name),
                        SizedBox(height: 19.ch),
                        CustomTextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            hint: Languages.of(context)!.mobileNumber,
                            hintStyle: TextStyle(
                              fontSize: 17.csp,
                              fontWeight: FontWeight.w400,
                              height: 22.ch / 17.csp,
                              color: CustomColors.tertiaryLight,
                            ),
                            hasBorder: true,
                            padding: EdgeInsets.only(bottom: 19.ch, left: 10),
                            errorText:
                                registerController.registerError.value?.phone),
                        SizedBox(height: 19.ch),
                        CustomTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            hint: Languages.of(context)!.email,
                            hintStyle: TextStyle(
                              fontSize: 17.csp,
                              fontWeight: FontWeight.w400,
                              height: 22.ch / 17.csp,
                              color: CustomColors.tertiaryLight,
                            ),
                            hasBorder: true,
                            padding: EdgeInsets.only(bottom: 19.ch, left: 10),
                            errorText:
                                registerController.registerError.value?.email),
                        SizedBox(height: 19.ch),
                        Obx(() => CustomTextField(
                            controller: passwordController,
                            obscureText:
                                registerController.passwordShowing.value,
                            hint: Languages.of(context)!.password,
                            hintStyle: TextStyle(
                              fontSize: 17.csp,
                              fontWeight: FontWeight.w400,
                              height: 22.ch / 17.csp,
                              color: CustomColors.tertiaryLight,
                            ),
                            hasBorder: true,
                            suffix: InkWell(
                              onTap: () {
                                registerController.togglePasswordShowing();
                              },
                              child: Icon(
                                registerController.passwordShowing.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: CustomColors.primary,
                              ),
                            ),
                            padding: EdgeInsets.only(bottom: 19.ch, left: 10),
                            errorText: registerController
                                .registerError.value?.password)),
                        SizedBox(height: 19.ch),
                        Obx(() => CustomTextField(
                            controller: confirmPasswordController,
                            obscureText:
                                registerController.confirmPasswordShowing.value,
                            textInputAction: TextInputAction.done,
                            hint: Languages.of(context)!.confirmPassword,
                            hintStyle: TextStyle(
                              fontSize: 17.csp,
                              fontWeight: FontWeight.w400,
                              height: 22.ch / 17.csp,
                              color: CustomColors.tertiaryLight,
                            ),
                            suffix: InkWell(
                              onTap: () {
                                registerController
                                    .toggleConfirmPasswordShowing();
                              },
                              child: Icon(
                                registerController.confirmPasswordShowing.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: CustomColors.primary,
                              ),
                            ),
                            hasBorder: true,
                            padding: EdgeInsets.only(bottom: 19.ch, left: 10),
                            errorText: registerController
                                .registerError.value?.confirmPassword)),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 4.w, top: 18.ch),
                child: Row(
                  children: [
                    Obx(() => Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          value: registerController.termsAccepted.value,
                          onChanged: (value) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return TermsAndConditionsBottomSheet();
                                });
                          },
                          splashRadius: 15.r,
                          activeColor: CustomColors.blue,
                          hoverColor: CustomColors.blue,
                          side: BorderSide(
                            color: CustomColors.tertiaryLight,
                            width: 1.5.w,
                          ),
                        )),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return TermsAndConditionsBottomSheet();
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "I agree with our ",
                            style: TextStyle(
                              color: CustomColors.secondary,
                              fontSize: 13.csp,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Terms",
                              style: TextStyle(
                                color: CustomColors.blue,
                                fontSize: 13.csp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            " and ",
                            style: TextStyle(
                              color: CustomColors.secondary,
                              fontSize: 13.csp,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Conditions",
                              style: TextStyle(
                                color: CustomColors.blue,
                                fontSize: 13.csp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 93.ch),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Obx(() => CustomButton(
                      onPressed: () {
                        registerController.register(
                            nameController.text.trim(),
                            phoneController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            confirmPasswordController.text.trim(),
                            context);
                      },
                      loading: registerController.loading.value,
                      width: MediaQuery.of(context).size.width * 0.5,
                      text: Languages.of(context)!.createAccount,
                      fontSize: 17.csp,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(height: 32.ch),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Languages.of(context)!.haveAccount,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.csp,
                      color: CustomColors.secondary,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      Languages.of(context)!.login,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.csp,
                        color: CustomColors.blue,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/pages.login", (route) => false);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TermsAndConditionsBottomSheet extends StatelessWidget {
  TermsAndConditionsBottomSheet({Key? key}) : super(key: key);

  final RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              defaultText(Languages.of(context)!.termsAndConditions,
                  color: CustomColors.primary, fontSize: 14),
              Divider(
                thickness: 1,
                height: 50,
              ),
              defaultText(Languages.of(context)!.termsAndConditionsText,
                  fontSize: 14),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: CustomButton(
                      onPressed: () {
                        registerController.acceptTermsAndConditions();
                        Navigator.pop(context);
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                      text: Languages.of(context)!.accept)),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
