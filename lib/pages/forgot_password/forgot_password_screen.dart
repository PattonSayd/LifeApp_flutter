import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../localization/languages/languages.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

TextEditingController emailTec = TextEditingController();
TextEditingController numberTec = TextEditingController();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

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
                  Languages.of(context)!.forgotPassword,
                  style: TextStyle(
                    fontSize: 34.csp,
                    height: 41.ch / 34.csp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.ch),
                Text(
                  Languages.of(context)!.forgotPasswordText,
                  style: TextStyle(
                    fontSize: 17.csp,
                    height: 22.ch / 17.csp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(60, 60, 67, 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.ch),
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
                CustomTextField(
                  controller: numberController,
                  keyboardType: TextInputType.emailAddress,
                  hint: Languages.of(context)!.mobileNumber,
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
                SizedBox(height: 30.ch),
                CustomButton(
                  onPressed: () {

                  },
                  text: Languages.of(context)!.restore,
                  fontSize: 17.csp,
                  width: MediaQuery.of(context).size.width * 0.5,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 32.ch),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
