import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/data.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/my_funds/my_funds_screen.dart';
import 'package:lifeapp/pages/targets/target_detail.dart';
import 'package:lifeapp/pages/targets/target_response.dart';
import 'package:lifeapp/pages/targets/targets_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TargetsScreen extends StatefulWidget {
  TargetsScreen({Key? key}) : super(key: key);

  @override
  State<TargetsScreen> createState() => _TargetsScreenState();
}

class _TargetsScreenState extends State<TargetsScreen> {
  final TargetsController targetsController = Get.put(TargetsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 220.ch,
                width: 1.sw,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF690FB7),
                      Color(0xFF770EB2),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(32.r),
                    bottomLeft: Radius.circular(32.r),
                  ),
                ),
                child: Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 24.w, right: 28.w, top: 20.ch),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 23.w),
                              ],
                            ),
                            SizedBox(height: 30.ch),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 133.w,
                                  child: defaultText(
                                    Languages.of(context)!.myCurrentTargets,
                                    fontSize: 18.csp,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.white,
                                  ),
                                ),
                                Obx(() => defaultText(
                                      targetsController.targets.value != null
                                          ? targetsController
                                              .targets.value!.targets!.length
                                              .toString()
                                          : '0',
                                      fontSize: 22.csp,
                                      color: CustomColors.white,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -0.04.sh,
                      right: -0.14.sw,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.ellipse4Svg,
                          height: 187.w,
                          width: 187.w,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20,
                      bottom: -0.02.sh,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.ellipse2Svg,
                          height: 102.w,
                          width: 102.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 246.ch,
              ),
              Positioned(
                bottom: 0.ch,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: EaseInWidget(
                    onTap: () {
                      Navigator.pushNamed(context, '/add-target');
                    },
                    child: Container(
                      height: 52.ch,
                      width: 52.ch,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(105, 15, 183, 0.24),
                            blurRadius: 15,
                            spreadRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(Assets.addSvg),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.ch),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  rowText(
                    text: Languages.of(context)!.targets,
                    onPressed: () {},
                  ),
                  Obx(() => targetsController.loading.value
                      ? CircularProgressIndicator.adaptive()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              targetsController.targets.value!.targets!.length,
                          itemBuilder: (context, index) {
                            return _targetItems(targetsController
                                .targets.value!.targets![index]);
                          })),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _targetItems(Target target) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TargetDetail(target: target,),
            ));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(left: 22.w, right: 22.w, bottom: 10.ch),
        padding:
            EdgeInsets.only(left: 17.w, right: 17.w, top: 12.ch, bottom: 12.ch),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: CustomColors.shadow,
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultText(
                  target.name!,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.textBlack,
                  fontSize: 16.csp,
                ),
                SizedBox(height: 7.ch),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: target.totalSum!.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: CustomColors.primary,
                          fontSize: 12.csp,
                        ),
                      ),
                      TextSpan(
                        text: "/" + target.sum!.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF646363),
                          fontSize: 12.csp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 6.0,
              animation: true,
              percent: (target.totalSum! / target.sum! ),
              center: defaultText(
                (target.totalSum! / target.sum! * 100).toStringAsFixed(0) + "%",
                fontWeight: FontWeight.w700,
                fontSize: 12.csp,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: CustomColors.primary,
              backgroundColor: Color.fromRGBO(105, 15, 183, 0.06),
            )
          ],
        ),
      ),
    );
  }
}
