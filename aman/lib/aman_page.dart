import 'dart:convert';

import 'package:aman/models/aman_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class AmanPage extends StatefulWidget {
  @override
  _AmanPageState createState() => _AmanPageState();
}

class _AmanPageState extends State<AmanPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController feesController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController exchangeRateController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController totalValueController = TextEditingController();


Future<Aman> submitData(
  int amount,
  int total,
  String type,
  int fees,
  String currency,
  int exchangeRate,
  int value,
  double totalValue,
) async {
   var headers = {
    "MERCHANT_PUBLIC_KEY": "AMANPUB6634801781243253.4080687977011781",
    // "MERCHAN_REFERENCE" : "5292731366",
    "Content-Type": "application/json",
    // "Authorization"  : "Bearer 5292731366"
  };

  Map<String, dynamic> availablePaymentMethod = {
    "name": "Aman Card",
    "reference": 123456,
    "code": "AmanCard",
  };

  Map<String, dynamic> data = {
    "amount": amount,
    "total": total,
    "type": type,
    "fees": fees,
    "currency": currency,
    "exchangeRate": exchangeRate,
    "value": value,
    "totalValue": totalValue,
    "availablePaymentMethods": [availablePaymentMethod], 
    
  };

  try {
    var response = await https.post(
      Uri.parse(
          'http://aman-checkout-backend.mimocodes.com/api/v1/create-payment-order'),
      body: jsonEncode(data),
      headers: headers,
    );

    var responseBody = response.body;
    print(responseBody);
    print(jsonEncode(data));

    if (response.statusCode == 200) {
      return amanFromJson(responseBody);
    } else {
      throw Exception(
          "Failed to create payment order: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Request failed: $e");
  }
}



  @override
  Widget build(BuildContext context) {
    Aman _aman;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aman Data Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const  InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: totalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Total'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: feesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Fees'),
              ),
              TextField(
                controller: currencyController,
                decoration:  const InputDecoration(labelText: 'Currency'),
              ),
              TextField(
                controller: exchangeRateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Exchange Rate'),
              ),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Value'),
              ),
              TextField(
                controller: totalValueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Total Value'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (totalController.text.isNotEmpty &&
                      amountController.text.isNotEmpty &&
                      typeController.text.isNotEmpty &&
                      feesController.text.isNotEmpty &&
                      currencyController.text.isNotEmpty &&
                      exchangeRateController.text.isNotEmpty &&
                      valueController.text.isNotEmpty &&
                      totalValueController.text.isNotEmpty) {
                    try {
                      int total = int.parse(totalController.text);
                      int amount = int.parse(amountController.text);
                      int fees = int.parse(feesController.text);
                      int exchangeRate = int.parse(exchangeRateController.text);
                      int value = int.parse(valueController.text);
                      double totalValue = double.parse(totalValueController.text);
      
                      Aman data = await submitData(
                        amount,
                        total,
                        typeController.text,
                        fees,
                        currencyController.text,
                        exchangeRate,
                        value,
                        totalValue,
                      );
      
                      setState(() {
                        _aman = data;
                      });
                    } catch (e) {
                      print("Error: $e");
                    }
                  } else {
                    print("Input fields are empty");
                  }
                },
                child: const Text('Send Aman Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}