import 'package:flutter/material.dart';

import 'order_confirmed_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

int selectedPayment = 0;

@override
Widget build(BuildContext context) {

return Scaffold(
backgroundColor: Colors.grey.shade50,

appBar: AppBar(
title: const Text("Payment Method"),
centerTitle: true,
),

body: Padding(
padding: const EdgeInsets.all(20),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

const Text(
"Choose how you'd like to pay",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 25),

Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),

child: RadioListTile<int>(
value: 0,
groupValue: selectedPayment,

activeColor: const Color(0xFFF57C00),

onChanged: (value) {
setState(() {
selectedPayment = value!;
});
},

title: const Text(
"Cash on Delivery",
style: TextStyle(
fontWeight: FontWeight.bold,
),
),

subtitle: const Text(
"Pay when your order arrives.",
),

secondary: const Icon(
Icons.payments,
color: Color(0xFFF57C00),
),
),
),

const SizedBox(height: 18),

Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),

child: RadioListTile<int>(
value: 1,
groupValue: selectedPayment,

activeColor: const Color(0xFFF57C00),

onChanged: (value) {
setState(() {
selectedPayment = value!;
});
},

title: const Text(
"Bank Transfer",
style: TextStyle(
fontWeight: FontWeight.bold,
),
),

subtitle: const Text(
"Transfer to Bellewise account.",
),

secondary: const Icon(
Icons.account_balance,
color: Color(0xFFF57C00),
),
),
),

const Spacer(),
  if (selectedPayment == 1)
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF57C00),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Bank Transfer Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          SizedBox(height: 12),

          Text("Bank: First Bank"),

          SizedBox(height: 6),

          Text(
            "Account Number: 0123456789",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 6),

          Text("Account Name: Bellewise Technologies Ltd"),

          SizedBox(height: 12),

          Text(
            "Transfer the exact amount before tapping Place Order.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),

  SizedBox(
    width: double.infinity,
    height: 58,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF57C00),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OrderConfirmedScreen(),
          ),
        );
      },
      child: const Text(
        "Place Order",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  const SizedBox(height: 20),
],
),
),
);
}
}