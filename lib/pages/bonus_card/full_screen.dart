import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifeapp/constants/assets.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({Key? key, this.code}) : super(key: key);

  final String? code;

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              Assets.closeSvg,
              color: Colors.black,
              width: 50,
            ),
          ),
          Center(child: SvgPicture.string(widget.code!)),
          SizedBox()
        ],
      )),
    );
  }
}
