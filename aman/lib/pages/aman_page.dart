import 'dart:convert';
import 'package:aman/models/aman_model.dart';
import 'package:aman/pages/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as https;

class AmanPage extends StatefulWidget {
  @override
  _AmanPageState createState() => _AmanPageState();
}



class _AmanPageState extends State<AmanPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController orderReferenceController = TextEditingController();
  String? mycashierUrl = '';

  Future<Aman> submitData(
    int amount,
    String currency,
    int orderReference
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'publicKey': 'AMANPUB6634801781243253.4080687977011781', 
      'Authorization': 'Bearer 5292731366'
    };
    Map<String, dynamic> data = {
      "amount": amount,
      "currency": currency,
      "orderReference" : orderReference 
    };
    try {
      var response = await https.post(
        Uri.parse(
            'http://aman-checkout-backend.mimocodes.com/api/v1/create-payment-order'),
        body: jsonEncode(data),
        headers: headers,
      );

      var responseBody = response.body;
      

      if (response.statusCode == 201) {
        mycashierUrl = amanFromJson(responseBody).cashierUrl;
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

  GlobalKey<FormState> formstate = GlobalKey();

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
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: amountController,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Amount'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Amount cannot be empty";
                    }
                  },
                ),
                TextFormField(
                  maxLength: 10,
                  controller: orderReferenceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Order refrence'),
                    validator: (value) {
                    if (value!.isEmpty) {
                      return "Order Refrence cannot be empty";
                    }
                  },
                ),
              
                TextFormField(
                  controller: currencyController,
                  decoration: const InputDecoration(labelText: 'Currency'),
                    validator: (value) {
                    if (value!.isEmpty) {
                      return "Currency cannot be empty";
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      try {
                        int amount = int.parse(amountController.text);
                        Aman data = await submitData(
                          amount,
                          currencyController.text,
                          int.parse(orderReferenceController.text)
                        );
                        
                        setState(() {
                          _aman = data;
                        });
                         Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  WebViewContainer(cashierUrl: mycashierUrl!,)),
                    );
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
      ),
    );
  }
}
