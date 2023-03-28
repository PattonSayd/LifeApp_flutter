import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/login/login_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 57.ch),
                Image.asset(Assets.logo),
                SizedBox(height: 32.ch),
                Text(
                  Languages.of(context)!.login,
                  style: TextStyle(
                    fontSize: 34.csp,
                    height: 41.ch / 34.csp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.ch),
                Text(
                  Languages.of(context)!.loginText,
                  style: TextStyle(
                    fontSize: 17.csp,
                    height: 22.ch / 17.csp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(60, 60, 67, 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.ch),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hint: Languages.of(context)!.email,
                  onEditingComplete: () {},
                  hintStyle: TextStyle(
                    fontSize: 17.csp,
                    fontWeight: FontWeight.w400,
                    height: 22.ch / 17.csp,
                    color: CustomColors.tertiaryLight,
                  ),
                  hasBorder: true,
                  padding: EdgeInsets.only(bottom: 19.ch, left: 10),
                ),
                SizedBox(height: 15.ch),
                Obx(() => CustomTextField(
                      controller: passwordController,
                      obscureText: loginController.passwordShowing.value,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      hint: Languages.of(context)!.password,
                      hintStyle: TextStyle(
                        fontSize: 17.csp,
                        fontWeight: FontWeight.w400,
                        height: 22.ch / 17.csp,
                        color: CustomColors.tertiaryLight,
                      ),
                      hasBorder: true,
                      padding:
                          EdgeInsets.only(bottom: 19.ch, top: 17.ch, left: 10),
                      suffix: InkWell(
                        onTap: () {
                          loginController.togglePassword();
                        },
                        child: Icon(
                          loginController.passwordShowing.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: CustomColors.primary,
                        ),
                      ),
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pages.forgot-password');
                    },
                    child: Text(
                      Languages.of(context)!.forgotPassword,
                      style: TextStyle(
                        color: CustomColors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.csp,
                        height: 18.ch / 13.csp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70.ch),
                Obx(() => SizedBox(
                    height: 40,
                    child: defaultText(loginController.error.value,
                        color: CustomColors.errorRed,
                        fontSize: 18.csp,
                        fontWeight: FontWeight.w500))),
                SizedBox(height: 20.ch),
                Obx(
                  () => loginController.confirmButtonShowing.value
                      ? CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/pages.account-verification");
                          },
                          text: Languages.of(context)!.confirmAccount,
                          fontSize: 17.csp,
                          fontWeight: FontWeight.w600,
                        )
                      : SizedBox(),
                ),
                SizedBox(height: 50.ch),
                Obx(() => CustomButton(
                      onPressed: () {
                        loginController.login(emailController.text,
                            passwordController.text, context);
                      },
                      loading: loginController.loading.value,
                      text: Languages.of(context)!.login,
                      fontSize: 17.csp,
                      width: MediaQuery.of(context).size.width * 0.5,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 32.ch),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context)!.doNotHaveAccount,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.csp,
                        color: CustomColors.secondary,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        Languages.of(context)!.signup,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.csp,
                          color: CustomColors.blue,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/pages.register", (route) => false);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
