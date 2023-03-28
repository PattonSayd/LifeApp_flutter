import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/pages/bonus_card/add_bonus_card.dart';
import 'package:lifeapp/pages/my_funds/create/my_fund_create_controller.dart';
import 'package:lifeapp/pages/my_funds/create/my_funds_request_dto.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../localization/languages/languages.dart';

class MyFundsAddScreen extends StatefulWidget {
  const MyFundsAddScreen({Key? key, required this.onBack}) : super(key: key);

  final VoidCallback onBack;

  @override
  State<MyFundsAddScreen> createState() => _MyFundsAddScreenState();
}

class _MyFundsAddScreenState extends State<MyFundsAddScreen>
    with TickerProviderStateMixin {
  PageController controller = PageController(viewportFraction: 0.85);
  final FundCreateController fundCreateController = FundCreateController();

  int changePage = 0;
  TextEditingController titleTEC = TextEditingController();
  TextEditingController balanceTEC = TextEditingController();
  TextEditingController identityNumberTEC = TextEditingController();

  List<MyFundCart> myCarts = [
    MyFundCart(
      subTitle: "Kart",
      title: "Debit",
      numbers: "5362 2100 0120 0001",
      otherCart: false,
      info:
          "Kart daxil edilməsi zamanı özünüzə məxsus istənilən növ plastik və rəqəmsal kartların əlavə edilməsini həyata keçirə bilərsiniz.",
    ),
    MyFundCart(
      subTitle: "Digər",
      title: "Paşa Bank Deposit",
      numbers: "15 000.00 AZN",
      otherCart: true,
      info:
          'Digər daxiletmələr zamanı siz özünüzə məxsus hansısa depozitlərinizi və ya nağd pul vəsaitlərinizi əlavə edə bilərsiniz.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Color(0xFFFEFDFE),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: widget.onBack,
            child: Center(
              child: SvgPicture.asset(
                Assets.closeSvg,
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
          title: defaultText(
            Languages.of(context)!.addFund,
            fontSize: 16.csp,
          ),
        ),
        body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.ch),
                SizedBox(
                  height: 250.ch,
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {
                      changePage = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return MyFundsCart(myFundCart: myCarts[index]);
                    },
                    itemCount: myCarts.length,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 28.w, right: 28.w),
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 18.ch,
                    bottom: 18.ch,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.shadow.withOpacity(0.06),
                        blurRadius: 6,
                        spreadRadius: 6,
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.carFillSvg),
                      SizedBox(width: 17.w),
                      Flexible(
                        child: defaultText(
                          myCarts[changePage].info,
                          fontSize: 14.csp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF66566E),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.ch),
                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 28.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Obx(() => TextFormField(
                            controller: titleTEC,
                            style: TextStyle(
                              fontSize: 16.csp,
                              fontWeight: FontWeight.w400,
                            ),
                            cursorColor: CustomColors.primary,
                            decoration: InputDecoration(
                              hintText: Languages.of(context)!.name,
                              errorText:
                                  fundCreateController.nameError.value != ""
                                      ? fundCreateController.nameError.value
                                      : null,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F1F1),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F1F1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: CustomColors.primary,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.ch),
                      Obx(() => TextFormField(
                            controller: balanceTEC,
                            style: TextStyle(
                              fontSize: 16.csp,
                              fontWeight: FontWeight.w400,
                            ),
                            cursorColor: CustomColors.primary,
                            decoration: InputDecoration(
                              hintText: Languages.of(context)!.balance,
                              errorText:
                                  fundCreateController.balanceError.value != ""
                                      ? fundCreateController.balanceError.value
                                      : null,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F1F1),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F1F1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: CustomColors.primary,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.ch),
                      if (!myCarts[changePage].otherCart)
                        Obx(() => TextFormField(
                              controller: identityNumberTEC,
                              style: TextStyle(
                                fontSize: 16.csp,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: CustomColors.primary,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                  mask: '#### #### #### ####',
                                  filter: {"#": RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.eager,
                                )
                              ],
                              decoration: InputDecoration(
                                hintText: Languages.of(context)!.last4Digit,
                                errorText: fundCreateController
                                            .identityNumberError.value !=
                                        ""
                                    ? fundCreateController
                                        .identityNumberError.value
                                    : null,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF1F1F1),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF1F1F1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: CustomColors.primary,
                                  ),
                                ),
                              ),
                            )),
                      SizedBox(height: 30.ch),
                      Obx(()=>CustomButton(
                        onPressed: () {
                          fundCreateController.nameError.value = "";
                          fundCreateController.balanceError.value = "";
                          fundCreateController.identityNumberError.value = "";
                          if (titleTEC.text.trim() == "") {
                            fundCreateController.nameError.value =
                                Languages.of(context)!.thisFieldCantBeEmpty;
                            print("a");
                            return;
                          }
                          if (balanceTEC.text.trim() == "") {
                            fundCreateController.balanceError.value =
                                Languages.of(context)!.thisFieldCantBeEmpty;
                            return;
                          }
                          if (!myCarts[changePage].otherCart &&
                              identityNumberTEC.text.trim() == "") {
                            fundCreateController.identityNumberError.value =
                                Languages.of(context)!.thisFieldCantBeEmpty;
                            return;
                          }

                          fundCreateController.create(MyFundsRequestDto(
                              name: titleTEC.text.trim(),
                              balance: double.parse(balanceTEC.text.trim()),
                              type: !myCarts[changePage].otherCart
                                  ? 'non-cash'
                                  : 'cash',
                              identityNumber: identityNumberTEC.text.trim()));
                        },
                        text: Languages.of(context)!.add,
                        loading: fundCreateController.loading.value,
                        fontSize: 16.csp,
                        fontWeight: FontWeight.w600,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyFundCart {
  final String title;
  final String subTitle;
  final String numbers;
  final bool otherCart;
  final String info;

  MyFundCart({
    required this.title,
    required this.numbers,
    required this.otherCart,
    required this.subTitle,
    required this.info,
  });
}

class MyFundsCart extends StatelessWidget {
  final MyFundCart myFundCart;

  const MyFundsCart({Key? key, required this.myFundCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(
          myFundCart.subTitle,
          fontSize: 22.csp,
        ),
        SizedBox(height: 16.ch),
        !myFundCart.otherCart
            ? Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    width: 268.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        colors: [
                          CustomColors.primary,
                          CustomColors.primary2,
                        ],
                      ),
                    ),
                    child: Image.asset(
                      Assets.cart,
                      width: 268.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.w, bottom: 28.ch),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                          myFundCart.title,
                          fontSize: 14.csp,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.white,
                        ),
                        SizedBox(height: 6.ch),
                        defaultText(
                          myFundCart.numbers,
                          color: CustomColors.white,
                          fontSize: 18.csp,
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    width: 268.w,
                    child: Image.asset(
                      Assets.otherCart,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                          myFundCart.title,
                          fontSize: 14.csp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 10.ch),
                        defaultText(
                          myFundCart.numbers,
                          fontSize: 18.csp,
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ],
    );
  }
}
