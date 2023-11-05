// To parse this JSON data, do
//
//     final aman = amanFromJson(jsonString);

import 'dart:convert';

Aman amanFromJson(String str) => Aman.fromJson(json.decode(str));

String amanToJson(Aman data) => json.encode(data.toJson());

class Aman {
  int reference;
  int amount;
  String type;
  int fees;
  int total;
  String currency;
  int exchangeRate;
  int value;
  double totalValue;
  String cashierUrl;
  List<AvailablePaymentMethod> availablePaymentMethods;

  Aman({
    required this.reference,
    required this.amount,
    required this.type,
    required this.fees,
    required this.total,
    required this.currency,
    required this.exchangeRate,
    required this.value,
    required this.totalValue,
    required this.cashierUrl,
    required this.availablePaymentMethods,
  });

  factory Aman.fromJson(Map<String, dynamic> json) => Aman(
        reference: json["reference"],
        amount: json["amount"],
        type: json["type"],
        fees: json["fees"],
        total: json["total"],
        currency: json["currency"],
        exchangeRate: json["exchangeRate"],
        value: json["value"],
        totalValue: json["totalValue"]?.toDouble(),
        cashierUrl: json["cashierUrl"],
        availablePaymentMethods: List<AvailablePaymentMethod>.from(
            json["availablePaymentMethods"]
                .map((x) => AvailablePaymentMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "amount": amount,
        "type": type,
        "fees": fees,
        "total": total,
        "currency": currency,
        "exchangeRate": exchangeRate,
        "value": value,
        "totalValue": totalValue,
        "cashierUrl": cashierUrl,
        "availablePaymentMethods":
            List<dynamic>.from(availablePaymentMethods.map((x) => x.toJson())),
      };
}

class AvailablePaymentMethod {
  String name;
  int reference;
  String code;

  AvailablePaymentMethod({
    required this.name,
    required this.reference,
    required this.code,
  });

  factory AvailablePaymentMethod.fromJson(Map<String, dynamic> json) =>
      AvailablePaymentMethod(
        name: json["name"],
        reference: json["reference"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "reference": reference,
        "code": code,
      };
}