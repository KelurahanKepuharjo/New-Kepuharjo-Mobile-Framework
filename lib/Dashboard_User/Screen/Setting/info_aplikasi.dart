import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/custom_navigation_drawer.dart';

class InfoAplikasi extends StatelessWidget {
  const InfoAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(" S-Kepuharjo",
                        style: MyFont.montserrat(
                            fontSize: 24,
                            color: black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "images/mylogo.png",
                      height: 45,
                    )
                  ],
                ),
              ),
              Text(
                "Versi 1.0.1",
                style: MyFont.poppins(
                    fontSize: 12, color: black, fontWeight: FontWeight.w300),
              ),
              Text(
                "Copyright © S-Kepuharjo 2023",
                style: MyFont.poppins(
                    fontSize: 12, color: black, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
