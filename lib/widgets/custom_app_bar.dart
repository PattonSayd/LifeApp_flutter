import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: CustomColors.primary.withOpacity(0.1),
      titleSpacing: 28.w,
      toolbarHeight: 84.ch,
      title: Image.asset(
        Assets.logo,
        height: 42.ch,
      ),
      actions: [
        SvgPicture.asset(
          Assets.bellSvg,
          color: CustomColors.primary,
          width: 32.w,
          height: 32.w,
        ),
        SizedBox(width: 13.w),
        GestureDetector(
          onTap: () async {
            Get.toNamed('/profile');
          },
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(
            Assets.userSvg,
            color: CustomColors.primary,
            width: 32.w,
            height: 32.w,
          ),
        ),
        SizedBox(width: 13.w),
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, '/create-shopping-list');
          },
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(
            Assets.messenger,
            color: CustomColors.primary,
            width: 26.w,
            height: 26.w,
          ),
        ),
        SizedBox(width: 22.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(84.ch);
}
