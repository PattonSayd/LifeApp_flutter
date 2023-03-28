import 'package:flutter/cupertino.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get myTargets;

  String get addBonusCard;

  String get selectPhoto;

  String get unallocatedCosts;

  String get addCategory;

  String get categoryName;

  String get subcategories;

  String get subcategory;

  String get addSubcategory;

  String get systemOffers;

  String get categoryAddText;

  String get add;

  String get detailedReviewOfCosts;

  String get search;

  String get byCategory;

  String get bySubCategory;

  String get selectFilters;

  String get category;

  String get brand;

  String get fromDate;

  String get toDate;

  String get confirm;

  String get week;

  String get month;

  String get year;

  String get receipts;

  String get receipt;

  String get mainCostDirections;

  String get detailed;

  String get expenditurePlans;

  String get manage;

  String get forToday;

  String get mySubCategory;

  String get ongoingCostPlans;

  String get scannedReceipts;

  String get manualWithImage;

  String get manualWithoutImage;

  String get payments;

  String get save;

  String get myCostPlan;

  String get connectedSubcategory;

  String get enterSubcategory;

  String get repetitiveCostPlan;

  String get costPlans;

  String get ongoingPlans;

  String get ongoing;

  String get all;

  String get cheapestPrices;

  String get more;

  String get usefulForYou;

  String get login;

  String get loginText;

  String get email;

  String get password;

  String get confirmPassword;

  String get forgotPassword;

  String get forgotPasswordText;

  String get doNotHaveAccount;

  String get signup;

  String get nameAndSurname;

  String get mobileNumber;

  String get birthDate;

  String get iAgreeWithOur;

  String get terms;

  String get and;

  String get conditions;

  String get createAccount;

  String get haveAccount;

  String get homePage;

  String get costs;

  String get funds;

  String get targets;

  String get receiptScan;

  String get addFund;

  String get selectFund;

  String get reviewOfCosts;

  String get myFunds;

  String get bonusCards;

  String get addPayment;

  String get productName;

  String get count;

  String get price;

  String get total;

  String get paymentType;

  String get other;

  String get cash;

  String get change;

  String get paymentName;

  String get amount;

  String get addReceipt;

  String get enterManually;

  String get addTarget;

  String get targetName;

  String get period;

  String get monthlyAmount;

  String get pay;

  String get myCurrentTargets;

  String get mainMenu;

  String get lookReceipt;

  String get successOperation;

  String get thisReceiptAlreadyExists;

  String get nameCantBeEmpty;

  String get emailCantBeEmpty;

  String get emailAlreadyUsed;

  String get phoneCantBeEmpty;

  String get phoneAlreadyUsed;

  String get passwordCantBeEmpty;

  String get passwordsDonTMatch;

  String get accountNotConfirmed;

  String get confirmAccount;

  String get verificationLinkSent;

  String get remainingTimeToSentAgain;

  String get seconds;

  String get comment;

  String get tsName;

  String get tsAddress;

  String get veenName;

  String get veen;

  String get objectCode;

  String get salesReceipt;

  String get cashier;

  String get date;

  String get checkCountDuringDay;

  String get cashRegisterModel;

  String get cashRegisterFactoryNumber;

  String get fiscalId;

  String get NMQRegistrationNumber;

  String get addToReceipt;

  String get thisFieldCantBeEmpty;

  String get enterName;

  String get name;

  String get balance;

  String get last4Digit;

  String get costPerTag;

  String get byTag;

  String get limit;

  String get tag;

  String get allFunds;

  String get delete;

  String get selectTag;

  String get selectCategory;

  String get selectSubCategory;

  String get scanAgain;

  String get enterCode;

  String get storeName;

  String get showReceiptHistory;

  String get downloaded;

  String get termsAndConditions;

  String get termsAndConditionsText;

  String get accept;

  String get enterAddress;

  String get address;

  String get enterWork;

  String get work;

  String get selectGender;

  String get male;

  String get female;

  String get logout;

  String get profile;

  String get resetPassword;

  String get enterMobileNumber;

  String get send;

  String get restore;

  String get youHaveNotCost;

  String get youCanSeeCostDetails;

  String get youHaveNotTagCost;

  String get youCanSeeTagCostDetails;

  String get youHaveNotCategoryCostPlan;

  String get youCanSeeCategoryCostPlanDetails;

  String get youHaveNotTagCostPlan;

  String get youCanSeeTagCostPlanDetails;

}