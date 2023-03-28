import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../localization/languages/languages.dart';
import '../../package/flutter_slidable/src/action_pane_motions.dart';
import '../../package/flutter_slidable/src/actions.dart';
import '../../package/flutter_slidable/src/slidable.dart';
import 'fund_response.dart';
import 'my_funds_controller.dart';

class AllFundsScreen extends StatelessWidget {
  AllFundsScreen({Key? key}) : super(key: key);
  final MyFundsController controller = Get.put(MyFundsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: SvgPicture.asset(
                Assets.closeSvg,
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
          centerTitle: true,
          title: defaultText(
            Languages.of(context)!.all,
            fontSize: 16.csp,
          ),
        ),
        body: Obx(() => ListView.builder(
            itemCount: controller.myFunds.value != null
                ? controller.myFunds.value!.funds!.length
                : 0,
            padding: new EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _slidableItem(index,
                  fund: controller.myFunds.value!.funds![index]);
            })));
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
                      if(fund.type! == 'non-cash')defaultText(
                         fund.name!,
                        color: CustomColors.grey3,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.csp,
                      ),
                      defaultText(
                        fund.type! == 'non-cash'
                            ? (fund.identityNumber != null ? '**** **** **** ' + fund.identityNumber.toString() : '**** **** **** ****')
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
}
