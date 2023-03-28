class MyFundsRequestDto {
  String? name;
  String? type;
  double? balance;
  String? identityNumber;

  MyFundsRequestDto({this.name, this.balance, this.identityNumber, this.type});

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "balance": balance,
        "identity_number": identityNumber
      };
}
