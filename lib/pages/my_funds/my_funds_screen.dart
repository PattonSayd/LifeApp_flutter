import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/my_funds/fund_response.dart';
import 'package:lifeapp/pages/my_funds/models/bonus_cart.dart';
import 'package:lifeapp/pages/my_funds/create/my_funds_add_screen.dart';
import 'package:lifeapp/package/flutter_slidable/flutter_slidable.dart';
import 'package:lifeapp/pages/my_funds/my_funds_controller.dart';

import '../../localization/languages/languages.dart';
import 'models/my_funds.dart';

class MyFundsScreen extends StatefulWidget {
  const MyFundsScreen({Key? key}) : super(key: key);

  @override
  State<MyFundsScreen> createState() => _MyFundsScreenState();
}

class _MyFundsScreenState extends State<MyFundsScreen>
    with TickerProviderStateMixin {
  GlobalKey? _scaffoldKey;
  final MyFundsController controller = Get.put(MyFundsController());

  bool addPage = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: !addPage
          ? Scaffold(
              key: _scaffoldKey,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: 187.ch,
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
                            alignment: Alignment.center,
                            children: [
                              SafeArea(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 28.w, right: 28.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 133.w,
                                        child: defaultText(
                                          Languages.of(context)!.reviewOfCosts,
                                          color: Colors.white,
                                          fontSize: 18.csp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Obx(() => defaultText(
                                                "Cash : " +
                                                    controller.cash.value
                                                        .toString(),
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.csp,
                                              )),
                                          Obx(() => defaultText(
                                                "Non Cash : " +
                                                    controller.nonCash.value
                                                        .toString(),
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.csp,
                                              )),
                                          Obx(() => defaultText(
                                                "Sum : " +
                                                    controller.sum.value
                                                        .toString(),
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.csp,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -0.09.sh,
                                right: -0.15.sw,
                                child: Center(
                                  child: SvgPicture.asset(
                                    Assets.ellipse4Svg,
                                    height: 187.w,
                                    width: 187.w,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
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
                          height: 213.ch,
                        ),
                        Positioned(
                          bottom: 0.ch,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: EaseInWidget(
                              onTap: () {
                                addPage = true;
                                setState(() {});
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
                    Padding(
                      padding: EdgeInsets.only(top: 10.ch),
                      child: rowText(
                        text: Languages.of(context)!.myFunds,
                        suffixText: Languages.of(context)!.all,
                        onPressed: () {
                          Navigator.pushNamed(context, '/pages.all-funds');
                        },
                      ),
                    ),
                    Obx(() => ListView.builder(
                        itemCount: controller.myFunds.value != null
                            ? controller.myFunds.value!.funds!.length
                            : 0,
                        padding: new EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _slidableItem(index,
                              fund: controller.myFunds.value!.funds![index]);
                        })),
                    rowText(
                      text: Languages.of(context)!.bonusCards,
                      suffixText: Languages.of(context)!.add,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      isPrimary: true,
                      onPressed: () {
                        Navigator.pushNamed(context, '/add-bonus-card');
                      },
                    ),
                    Obx(() => ListView.builder(
                        itemCount: controller.bonusCards.length,
                        padding: new EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _slidableItemBonusCard(index,
                              bonusCart: controller.bonusCards[index]);
                        })),
                  ],
                ),
              ),
            )
          : MyFundsAddScreen(onBack: () {
              addPage = false;
              setState(() {});
            }),
    );
  }

  Widget _slidableItem(int index, {required Fund fund}) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.ch, right: 20.w, top: 4.ch),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          dragDismissible: false,
          extentRatio: 0.19,
          motion: BehindMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (BuildContext context) {},
              backgroundColor: CustomColors.red,
              foregroundColor: Colors.white,
              svg: SvgPicture.asset(Assets.deleteSvg),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(left: 20.w, top: 6.ch, bottom: 6.ch),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.ch),
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: CustomColors.shadow,
                blurRadius: 6,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    fund.type! == 'non-cash'
                        ? Icons.credit_card
                        : Icons.attach_money,
                    color: CustomColors.primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fund.type! == 'non-cash')
                        defaultText(
                          fund.name!,
                          color: CustomColors.grey3,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.csp,
                        ),
                      defaultText(
                        fund.type! == 'non-cash'
                            ? (fund.identityNumber != null
                                ? '**** **** **** ' +
                                    fund.identityNumber.toString()
                                : '**** **** **** ****')
                            : fund.name!,
                        color: CustomColors.textBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.csp,
                      ),
                    ],
                  )
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: fund.balance!.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.csp,
                      ),
                    ),
                    TextSpan(
                      text: ' AZN',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.csp,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _slidableItemBonusCard(int index, {required BonusCard bonusCart}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/bonus-card-detail",
            arguments: {"name": bonusCart.vendor, "code": bonusCart.code});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4.ch, right: 20.w, top: 4.ch),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            dragDismissible: false,
            extentRatio: 0.19,
            motion: BehindMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (BuildContext context) {
                  controller.deleteBonusCard(index);
                },
                backgroundColor: CustomColors.red,
                foregroundColor: Colors.white,
                svg: SvgPicture.asset(Assets.deleteSvg),
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20.w, top: 6.ch, bottom: 6.ch),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.ch),
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.shadow,
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                defaultText(
                  bonusCart.vendor!,
                  color: CustomColors.hintText,
                  fontSize: 14.csp,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  Color color;

  _MyPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    double r = 16;

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path topRightArc = Path()
      ..moveTo(w - r, 0)
      ..arcToPoint(
        Offset(w + 1, r),
        radius: Radius.circular(r),
      )
      ..lineTo(w, 0)
      ..lineTo(w - r, 0);

    Path topLeftArc = Path()
      ..moveTo(w, h - r)
      ..arcToPoint(
        Offset(w - r, h),
        radius: Radius.circular(r),
      )
      ..lineTo(w + 1, h);
    // ..lineTo(w, h - r);

    // canvas.drawRRect(fullRect, blackPaint);
    canvas.drawPath(topRightArc, paint);
    canvas.drawPath(topLeftArc, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class EaseInWidget extends StatefulWidget {
  final Widget child;
  final Function onTap;

  const EaseInWidget({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EaseInWidgetState();
}

class _EaseInWidgetState extends State<EaseInWidget>
    with TickerProviderStateMixin<EaseInWidget> {
  late AnimationController controller;
  late Animation<double> easeInAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
        value: 1.0);
    easeInAnimation = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap == null) {
          return;
        }
        controller.reverse().then((val) {
          controller.forward().then((val) {
            widget.onTap();
          });
        });
      },
      child: ScaleTransition(
        scale: easeInAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
