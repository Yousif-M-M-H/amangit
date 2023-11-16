import 'package:flutter/material.dart';

class PaymentDone extends StatelessWidget {
  const PaymentDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        widthFactor: 23,
        child: const Text("we got your order successfully", textAlign: TextAlign.center, style: TextStyle(
          color: Colors.green,
          fontSize: 30
        ),),
      ),
    );
  }
}