import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    // var paymentNotifier = Provider.of<PaymentNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          // onTap: () {
          //   paymentNotifier.paymentUrl = '';
          //   Navigator.pushReplacement(
          //       context, MaterialPageRoute(builder: (context) => const MainScreen()));
          // },
          child: const Icon(
            AntDesign.closecircleo,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/Checkmark.png"),
            ReusableText(
                text: "Payment Successful",
                style: appstyle(28, Colors.black, FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
