import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/custom_navigation_drawer.dart';

class InfoAplikasi extends StatelessWidget {
  const InfoAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(28.0),
                child: Image.asset(
                  'images/tompokersan.png',
                  height: 60,
                )),
            Text(
              "Versi 1.0.1",
              style: MyFont.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.w300),
            ),
            Text(
              "Copyright © S-Tompokersan 2024",
              style: MyFont.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
