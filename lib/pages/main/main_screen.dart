import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/pages/costs/tag/tag_controller.dart';
import 'package:lifeapp/pages/create_receipt/create/qr_scan_screen.dart';
import 'package:lifeapp/pages/main/main_controller.dart';
import 'package:lifeapp/pages/my_funds/my_funds_screen.dart';
import 'package:lifeapp/pages/costs/costs_screen.dart';
import 'package:lifeapp/pages/home/home_screen.dart';
import 'package:lifeapp/pages/targets/targets_screen.dart';

import '../../localization/languages/languages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController mainController = Get.put(MainController());
  final TagController tagController = Get.put(TagController());

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    CostsScreen(),
    MyFundsScreen(),
    TargetsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Obx(() => mainController.pageIndex == 4
              ? QrScanScreen(isBottomBar: true)
              : IndexedStack(
                  index: mainController.pageIndex.value,
                  children: _pages,
                )),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: CustomColors.navigationBarLight.withOpacity(0.94),
              border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: CustomColors.secondary.withOpacity(0.2),
                ),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: CustomColors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: mainController.pageIndex.value,
              selectedItemColor: CustomColors.primary,
              unselectedItemColor: Color.fromRGBO(102, 86, 110, 1),
              selectedLabelStyle: TextStyle(
                fontSize: 10.csp,
                fontWeight: FontWeight.w400,
              ),
              unselectedLabelStyle: TextStyle(
                color: Color.fromRGBO(102, 86, 110, 1),
                fontSize: 10.csp,
                fontWeight: FontWeight.w400,
              ),
              showSelectedLabels: true,
              onTap: (index) {
                mainController.onItemTapped(index);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.homeSvg,
                      color: Color.fromRGBO(102, 86, 110, 1),
                    ),
                  ),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.homeSvg,
                    ),
                  ),
                  label: Languages.of(context)!.homePage,
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(Assets.costMoneySvg,
                        color: Color.fromRGBO(102, 86, 110, 1)),
                  ),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.costMoneySvg,
                      color: CustomColors.primary,
                    ),
                  ),
                  label: Languages.of(context)!.costs,
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(Assets.walletSvg,
                        color: Color.fromRGBO(102, 86, 110, 1)),
                  ),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.walletSvg,
                      color: CustomColors.primary,
                    ),
                  ),
                  label: Languages.of(context)!.funds,
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.targetSvg,
                      color: Color.fromRGBO(102, 86, 110, 1),
                    ),
                  ),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.targetSvg,
                      color: CustomColors.primary,
                    ),
                  ),
                  label: Languages.of(context)!.targets,
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.scanSvg,
                      color: Color.fromRGBO(102, 86, 110, 1),
                    ),
                  ),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 5.ch),
                    child: SvgPicture.asset(
                      Assets.scanSvg,
                      color: CustomColors.primary,
                    ),
                  ),
                  label: Languages.of(context)!.receiptScan,
                ),
              ],
            ),
          ),
        ));
  }
}
