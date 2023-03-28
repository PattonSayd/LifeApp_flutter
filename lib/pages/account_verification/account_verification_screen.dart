import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/account_verification/account_verification_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';

class AccountVerification extends StatefulWidget {
  const AccountVerification({Key? key}) : super(key: key);

  @override
  State<AccountVerification> createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  final AccountVerificationController accountVerificationController =
      Get.put(AccountVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.close),
              ),
            ),
            Center(child: Image.asset(Assets.logo)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    defaultText(Languages.of(context)!.accountNotConfirmed,
                        fontSize: 20.csp),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => defaultText(
                        accountVerificationController.success.value
                            ? Languages.of(context)!.verificationLinkSent
                            : "",
                        textAlign: TextAlign.center,
                        fontSize: 18.csp,
                        color: CustomColors.successGreen)),
                    Obx(() => defaultText(
                        accountVerificationController.error.value
                            ? Languages.of(context)!.remainingTimeToSentAgain +
                                accountVerificationController.nextTime.value
                                    .toString() +
                                " " +
                                Languages.of(context)!.seconds
                            : "",
                        textAlign: TextAlign.center,
                        fontSize: 18.csp,
                        color: CustomColors.errorRed))
                  ],
                ),
              ),
            ),
            Center(
              child: Obx(() => CustomButton(
                    onPressed: () {
                      accountVerificationController.resendEmail();
                    },
                    loading: accountVerificationController.loading.value,
                    text: Languages.of(context)!.confirmAccount,
                    fontSize: 17.csp,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
