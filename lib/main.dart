import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lifeapp/bindings.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/localization/localizations_delegate.dart';
import 'package:lifeapp/pages/account_verification/account_verification_screen.dart';
import 'package:lifeapp/pages/bonus_card/bonus_cart_detail.dart';
import 'package:lifeapp/pages/costs/category/category_cost_screen.dart';
import 'package:lifeapp/pages/costs/costs_screen.dart';
import 'package:lifeapp/pages/costs/tag/tag_screen.dart';
import 'package:lifeapp/pages/create_receipt/create/qr_scan_add_screen.dart';
import 'package:lifeapp/pages/create_receipt/create/qr_scan_screen.dart';
import 'package:lifeapp/pages/expenditure/expenditure_plans_screen.dart';
import 'package:lifeapp/pages/forgot_password/forgot_password_screen.dart';
import 'package:lifeapp/pages/home/home_screen.dart';
import 'package:lifeapp/pages/main/main_screen.dart';
import 'package:lifeapp/pages/my_funds/all_funds_screen.dart';
import 'package:lifeapp/pages/my_funds/my_funds_screen.dart';
import 'package:lifeapp/pages/bonus_card/add_bonus_card.dart';
import 'package:lifeapp/pages/login/login_screen.dart';
import 'package:lifeapp/pages/profile/profile_screen.dart';
import 'package:lifeapp/pages/manual_add_cost/manual_add_screen.dart';
import 'package:lifeapp/pages/receipts/receipts_screen.dart';
import 'package:lifeapp/pages/register/register_screen.dart';
import 'package:lifeapp/pages/shopping_list/create/create_shopping_list_screen.dart';
import 'package:lifeapp/pages/splash/splash_screen.dart';
import 'package:lifeapp/pages/targets/add/add_target_screen.dart';
import 'package:lifeapp/pages/targets/target_detail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifeapp/pages/vat_receipt_history/webview/vat_webview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 938),
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (context) => GetMaterialApp(
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          initialBinding: InitialBinding(),
          debugShowCheckedModeBanner: false,
          routes: {
            '/pages.home': (context) => HomeScreen(),
            '/pages.main': (context) => MainScreen(),
            '/pages.register': (context) => RegisterScreen(),
            '/pages.login': (context) => LoginScreen(),
            '/pages.forgot-password': (context) => ForgotPassword(),
            '/pages.account-verification': (context) => AccountVerification(),
            '/pages.costs': (context) => CostsScreen(),
            '/profile': (context) => ProfileScreen(),
            '/pages.my_funds': (context) => MyFundsScreen(),
            '/pages.all-funds': (context) => AllFundsScreen(),
            '/add-target': (context) => AddTarget(),
            '/target-detail': (context) => TargetDetail(),
            '/add-bonus-card': (context) => AddBonusCard(),
            '/bonus-card-detail': (context) => BonusCardDetailScreen(),
            '/pages.costs-details': (context) => CategoryCostsScreen(),
            '/pages.costs-per-tag': (context) => TagScreen(),
            '/qr-scan': (context) => QrScanScreen(),
            '/qr-scan-add': (context) => QrScanAddScreen(),
            '/qr-scan-manual-add': (context) => ManualAddScreen(),
            '/pages.receipts_history': (context) => ReceiptsScreen(),
            '/pages.expenditure-plans': (context) => ExpenditurePlansScreen(),
            '/pages.vat-web-view': (context) => VatHistoryWebViewScreen(),
            '/create-shopping-list': (context) => CreateShoppingListScreen(),
          },
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "EuclidCircularB",
            primaryColor: CustomColors.primary,
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: CustomColors.primary,
              onPrimary: CustomColors.white,
              secondary: CustomColors.blue,
              onSecondary: CustomColors.primary,
              error: CustomColors.red,
              onError: CustomColors.red,
              background: CustomColors.white,
              onBackground: CustomColors.white,
              surface: CustomColors.textBlack,
              onSurface: CustomColors.textBlack,
            ),
          ),
          locale: _locale,
          supportedLocales: const [Locale('az', '')],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: SplashScreen()),
      // home: ReceiptWebViewScreen(fiscal: 'FJfUZTNkCGSi')),
    );
  }
}
