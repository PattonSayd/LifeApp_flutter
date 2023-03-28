import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/pages/bonus_card/full_screen.dart';

class BonusCardDetailScreen extends StatefulWidget {
  const BonusCardDetailScreen({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  State<BonusCardDetailScreen> createState() => _BonusCardDetailScreenState();
}

class _BonusCardDetailScreenState extends State<BonusCardDetailScreen> {
  String _qr = "";
  String _barcode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    String code = arguments['code'];

    _qr = Barcode.qrCode().toSvg(code,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8);

    _barcode = Barcode.code128().toSvg(
      code,
      width: MediaQuery.of(context).size.width * 0.8,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['name']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return FullScreen(
                            code: _qr,
                          );
                        });
                  },
                  child: SvgPicture.string(_qr))),
          Center(
              child: GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return FullScreen(
                            code: _barcode,
                          );
                        });
                  },
                  child: SvgPicture.string(_barcode))),
        ],
      ),
    );
  }
}
