import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/app_constants.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/data.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/main/main_controller.dart';
import 'package:lifeapp/pages/story/story_modal.dart';
import 'package:lifeapp/pages/targets/target_detail.dart';
import 'package:lifeapp/widgets/custom_app_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../quick_add/quick_add_modal.dart';
import '../targets/target_response.dart';
import '../targets/targets_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TargetsController targetsController = Get.put(TargetsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F5F6),
      appBar: CustomAppBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 10,),
          FloatingActionButton(
            heroTag: 'homeFloatingAction',
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) {
                    return QuickAddDialog();
                  });
            },
            backgroundColor: CustomColors.primary,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(),
              margin: EdgeInsets.only(bottom: 1.ch),
              shadowColor: CustomColors.shadow,
              child: Padding(
                padding: EdgeInsets.only(left: 0.w, top: 22.ch, bottom: 22.ch),
                child: SizedBox(
                  height: 50.w,
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 28.w),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return StoryModal();
                              });
                        },
                        child: Container(
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(
                              color: CustomColors.primary,
                              width: 1.5.w,
                            ),
                          ),
                          padding: EdgeInsets.all(6.r),
                          margin: EdgeInsets.only(right: 16.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.r),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: CustomColors.white,
            //     boxShadow: [],
            //   ),
            //   padding: EdgeInsets.only(bottom: 40.ch, top: 40.ch),
            //   child: SizedBox(
            //     height: 164.ch,
            //     child: ListView.builder(
            //       itemCount: homeSliders.length,
            //       scrollDirection: Axis.horizontal,
            //       padding: EdgeInsets.only(left: 28.w),
            //       itemBuilder: (context, index) {
            //         return _firstSliderItem(
            //             homeSliderModel: homeSliders[index]);
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(height: 28.ch),
            rowText(
              text: Languages.of(context)!.myTargets,
              suffixText: Languages.of(context)!.all,
              onPressed: () {
                MainController mainController = Get.find();
                mainController.onItemTapped(3);
              },
            ),
            SizedBox(height: 20.ch),
            Obx(() => targetsController.loading.value
                ? CircularProgressIndicator.adaptive()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: targetsController.homeTargets.length,
                    itemBuilder: (context, index) {
                      return _targetItems(
                          targetsController.homeTargets[index], context);
                    })),
            SizedBox(height: 10.ch),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 20.ch),
              child: Column(
                children: [
                  SizedBox(height: 40.ch),
                  rowText(
                    text: Languages.of(context)!.cheapestPrices,
                    suffixText: Languages.of(context)!.more,
                    onPressed: () {},
                  ),
                  SizedBox(height: 23.ch),
                  ...List.generate(homeScreenPriceList.length, (index) {
                    HomeScreenPrice homeScreenPrice =
                        homeScreenPriceList[index];
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 10.ch),
                      height: 100.ch,
                      decoration: AppConstants.defaultDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 13.ch),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                defaultText(
                                  homeScreenPrice.title!,
                                  fontSize: 14.csp,
                                  fontWeight: FontWeight.w600,
                                ),
                                defaultText(
                                  "12.01.22",
                                  fontSize: 12.csp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF66566E),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 11.ch),
                          SizedBox(
                            height: 45.ch,
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 20.w),
                              scrollDirection: Axis.horizontal,
                              itemCount: homeScreenPrice.items!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Item item = homeScreenPrice.items![index];
                                if (index == 0)
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.primary,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
                                    margin: EdgeInsets.only(
                                        right: (homeScreenPrice.items!.length -
                                                    1 !=
                                                index)
                                            ? 15.w
                                            : 0.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Assets.bookmarkSvg,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            defaultText(
                                              item.title!,
                                              color: Colors.white,
                                              fontSize: 10.csp,
                                              fontWeight: FontWeight.w600,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            defaultText(
                                              item.price!,
                                              color: Colors.white,
                                              fontSize: 12.csp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                else
                                  return Container(
                                    width: 130.w,
                                    padding: EdgeInsets.only(
                                        right: (homeScreenPrice.items!.length -
                                                    1 !=
                                                index)
                                            ? 15.w
                                            : 0.w),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            defaultText(
                                              item.title!.length > 13
                                                  ? item.title!
                                                          .substring(0, 13) +
                                                      "..."
                                                  : item.title!,
                                              color: Color(0xFF251031),
                                              fontSize: 12.csp,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5.ch),
                                            defaultText(
                                              item.price!,
                                              color: Color(0xFF251031)
                                                  .withOpacity(0.5),
                                              fontSize: 14.csp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        if (homeScreenPrice.items!.length - 1 !=
                                            index)
                                          Container(
                                            width: 1,
                                            color: Color(0xFFD0CECE),
                                          ),
                                      ],
                                    ),
                                  );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 28.w, right: 28.w, bottom: 20.ch, top: 28.ch),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(
                    Languages.of(context)!.usefulForYou,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.csp,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      primary: CustomColors.primary.withOpacity(0.06),
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 10.ch,
                        bottom: 10.ch,
                      ),
                    ),
                    child: defaultText(
                      Languages.of(context)!.all,
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.csp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.primary.withOpacity(0.06),
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 16.ch,
                  left: 28.w,
                  right: 28.w,
                  bottom: 32.ch,
                ),
                child: Column(
                  children: [
                    defaultText(
                      "PAŞA Bank Kartınızı yeni tətbiqimizdən Google Wallet-ə indi əlavə edin",
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 30.ch),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            Assets.pasha1,
                            height: 188.ch,
                            width: 1.sw,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.ch),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.primary.withOpacity(0.06),
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 16.ch,
                  left: 28.w,
                  right: 28.w,
                  bottom: 32.ch,
                ),
                child: Column(
                  children: [
                    defaultText(
                      "PAŞA Bank Əmək haqqı kartı artıq keşbek qazandırır",
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 30.ch),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            Assets.pasha2,
                            height: 188.ch,
                            width: 1.sw,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.ch),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.primary.withOpacity(0.06),
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 16.ch,
                  left: 28.w,
                  right: 28.w,
                  bottom: 32.ch,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.asset(Assets.araz),
                        ),
                        SizedBox(width: 10.w),
                        defaultText(
                          "ARAZ Market",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.csp,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.w),
                    defaultText(
                      "Sağlam qidalarınızı ARAZ Marketlərindən əldə edin. Pulsuz çatdırılma, qapıda nağdsız ödəmə ilə artıq daha rahat.",
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 30.ch),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        Assets.araz2,
                        height: 188.ch,
                        width: 1.sw,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.ch),
          ],
        ),
      ),
    );
  }

  Container _firstSliderItem({required HomeSliderModel homeSliderModel}) {
    return Container(
      width: 265.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: CustomColors.primary,
          width: 2.w,
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF690FB7),
            Color(0xFF770EB2),
          ],
        ),
      ),
      padding: EdgeInsets.only(left: 20.ch, top: 20.ch, bottom: 13.ch),
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
            homeSliderModel.title,
            fontSize: 16.csp,
            color: CustomColors.white,
          ),
          SizedBox(height: 20.w),
          Row(
            children: [
              SvgPicture.asset(
                homeSliderModel.icon,
                width: 24.w,
                height: 24.w,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  defaultText(
                    homeSliderModel.centerText,
                    fontSize: 24.csp,
                    color: CustomColors.white,
                  ),
                  SizedBox(width: 8.w),
                  if (homeSliderModel.smallText != '')
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.ch),
                      child: defaultText(
                        homeSliderModel.smallText,
                        fontSize: 14.csp,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.white,
                      ),
                    ),
                ],
              )
            ],
          ),
          SizedBox(height: 0.w),
          defaultText(
            homeSliderModel.subTitle,
            fontSize: 14.csp,
            fontWeight: FontWeight.w400,
            color: CustomColors.white,
          ),
        ],
      ),
    );
  }

  Widget _targetItems(Target target, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TargetDetail(
                target: target,
              ),
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
              percent: (target.totalSum! / target.sum!),
              center: defaultText(
                (target.totalSum! / target.sum! * 100).toStringAsFixed(0) + "%",
                fontWeight: FontWeight.w700,
                fontSize: 12.csp,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: CustomColors.primary,
              backgroundColor: Color.fromRGBO(105, 15, 183, 0.06),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeSliderModel {
  final String title;
  final String subTitle;
  final String centerText;
  final String icon;
  final String smallText;

  HomeSliderModel({
    required this.title,
    required this.subTitle,
    required this.centerText,
    required this.smallText,
    required this.icon,
  });
}

var homeSliders = [
  HomeSliderModel(
    title: "Sənin qədər maaş alan şəxslər ortalama",
    subTitle: "qənaət ediblər",
    centerText: "12%",
    icon: Assets.rocketLaunchSvg,
    smallText: '',
  ),
  HomeSliderModel(
    title: "Hyundai Accent sürücüləri bu ay sizinlə müqaisədə ortalama",
    subTitle: "sərfiyyat ediblər",
    centerText: "50 ",
    icon: Assets.glowingStarSvg,
    smallText: 'AZN',
  ),
];
