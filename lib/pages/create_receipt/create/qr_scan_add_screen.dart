import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/widgets/custom_button.dart';

class QrScanAddScreen extends StatefulWidget {
  const QrScanAddScreen({Key? key}) : super(key: key);

  @override
  State<QrScanAddScreen> createState() => _QrScanAddScreenState();
}

class _QrScanAddScreenState extends State<QrScanAddScreen> {
  List<String> categories = [
    "Elektronika",
    "Market",
    "Otel",
    "Transport",
  ];

  String? selectCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: CustomColors.primary.withOpacity(0.08),
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
          Languages.of(context)!.addPayment,
          fontSize: 16.csp,
        ),
      ),
      bottomNavigationBar: Container(
        height: 144.ch,
        padding: EdgeInsets.symmetric(vertical: 20.ch, horizontal: 28.w),
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: [
            BoxShadow(
              color: CustomColors.primary.withOpacity(0.06),
              offset: Offset(0, -2),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              fontSize: 16.csp,
              fontWeight: FontWeight.w600,
              onPressed: () {},
              text: Languages.of(context)!.save,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 28.w,
            right: 28.w,
            bottom: ScreenUtil().bottomBarHeight + 18.ch,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.ch),
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF690FB7),
                      Color(0xFF770EB2),
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 16.w, bottom: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                            "TS Adı: Rahat market METROPARK",
                            fontSize: 18.csp,
                            color: CustomColors.white,
                          ),
                          SizedBox(height: 2.ch),
                          defaultText(
                            "Fiscal ID: Ks839Wjp02",
                            fontSize: 16.csp,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.white.withOpacity(0.7),
                          ),
                          SizedBox(height: 20.ch),
                          defaultText(
                            Languages.of(context)!.category,
                            fontSize: 18.csp,
                            color: CustomColors.white,
                          ),
                          SizedBox(height: 10.ch),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      Languages.of(context)!.category,
                                      style: TextStyle(
                                        fontSize: 16.csp,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.textBlack,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              items: categories
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 16.csp,
                                            fontWeight: FontWeight.w400,
                                            color: CustomColors.textBlack,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectCategory,
                              onChanged: (value) {
                                setState(() {
                                  selectCategory = value.toString();
                                });
                              },
                              icon: SvgPicture.asset(Assets.arrowDownSvg),
                              buttonHeight: 50.h,
                              buttonPadding: EdgeInsets.only(
                                left: 16.w,
                                right: 20.w,
                              ),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: CustomColors.border,
                                ),
                                color: CustomColors.white,
                              ),
                              buttonElevation: 0,
                              itemHeight: 40.ch,
                              itemPadding:
                                  EdgeInsets.only(left: 14.w, right: 14.w),
                              dropdownMaxHeight: 200.ch,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white,
                                border: Border.all(
                                  color: CustomColors.border,
                                ),
                              ),
                              dropdownElevation: 0,
                              offset: Offset(0, -5.ch),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -90,
                      right: -70,
                      child: Transform.rotate(
                        angle: -3.1,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.ellipse2Svg,
                            height: 187.w,
                            width: 187.w,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -60,
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
              SizedBox(height: 20.ch),
              Column(
                children: [
                  defaultText(
                    'TS ünvanı: AZ1049 BAKI ŞƏHƏRİ SURAXANI RAYONU BÜLBÜLƏ ŞTQ SƏTTAR BƏHLULZADƏ (ƏMİRCAN QƏS.) ev.73 R',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 10.ch),
                  defaultText(
                    'VÖ ADI: "BUTA FARM" MƏHDUD MƏSULİYYƏTLİ CƏMİYYƏTİ',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    'VÖEN: 1401383441',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    'Obyektin kodu: 1401383441-19037',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    'Satış çeki № 65653',
                    textAlign: TextAlign.center,
                    color: Color(0xFF66566E),
                  ),
                ],
              ),
              SizedBox(height: 20.ch),
              defaultText(
                'Kassir: Kəmalə Abbasova',
                fontWeight: FontWeight.w400,
                color: Color(0xFF66566E),
              ),
              defaultText(
                'Tarix: 09.04.2022 Saat: 17:32:03',
                fontWeight: FontWeight.w400,
                color: Color(0xFF66566E),
              ),
              SizedBox(height: 20.ch),
              Divider(
                color: Color(0xFFBCB4C0),
                thickness: 1,
                height: 0,
              ),
              SizedBox(height: 25.ch),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(Languages.of(context)!.productName),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              Languages.of(context)!.count,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              Languages.of(context)!.price,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              Languages.of(context)!.total,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.ch),
                  Divider(
                    color: Color(0xFFF2F2F2),
                    thickness: 1,
                    height: 0,
                  ),
                  SizedBox(height: 10.ch),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                            "Gilezi yumurta ed",
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 3.ch),
                          defaultText(
                            "*ƏDV 18%",
                            fontWeight: FontWeight.w400,
                            fontSize: 10.csp,
                            color: Color(0xFF66566E),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "(ədəd)",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "10.000",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "0.19",
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "1.90",
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 5.ch),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      defaultText(
                        "Qida məhsulu",
                        fontWeight: FontWeight.w400,
                        color: CustomColors.primary,
                      ),
                      SizedBox(width: 7.w),
                      SvgPicture.asset(
                        Assets.arrowDownSvg,
                        width: 6.ch,
                        height: 6.ch,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(height: 11.ch),
                  Divider(
                    color: Color(0xFFBCB4C0),
                    thickness: 1,
                    height: 0,
                  ),
                  SizedBox(height: 10.ch),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                            "Gilezi yumurta ed",
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 3.ch),
                          defaultText(
                            "*ƏDV 18%",
                            fontWeight: FontWeight.w400,
                            fontSize: 10.csp,
                            color: Color(0xFF66566E),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "(ədəd)",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "10.000",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "0.19",
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            child: defaultText(
                              "1.90",
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 34.ch),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultText(
                    "Gün ərzində vurulmuş çek sayı : 198",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    "Kassanın modeli: Wincor Nixdorf BEETLE/M-III",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    "Kassa aparatının zavod nömrəsi: 530332144",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    "Fiskal İD: 4dSBemm9VcS6",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  defaultText(
                    "NMQ-nun qeydiyyat nömrəsi: 0000002158",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF66566E),
                  ),
                  SizedBox(height: 20.ch),
                  Center(
                    child: Image.asset(
                      Assets.qrcode,
                      width: 125.ch,
                      height: 125.ch,
                    ),
                  ),
                  SizedBox(height: 20.ch),
                  Divider(
                    color: Color(0xFFBCB4C0),
                    thickness: 1,
                    height: 0,
                  ),
                  SizedBox(height: 20.ch),
                  defaultText(
                    Languages.of(context)!.paymentType,
                    fontSize: 14.csp,
                  ),
                  SizedBox(height: 10.ch),
                  Container(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    height: 66.ch,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.primary.withOpacity(0.06),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultText(
                              Languages.of(context)!.other,
                              color: CustomColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                            defaultText(
                              Languages.of(context)!.cash,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 38.ch,
                          child: CustomButton(
                            onPressed: () {},
                            text: Languages.of(context)!.change,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
