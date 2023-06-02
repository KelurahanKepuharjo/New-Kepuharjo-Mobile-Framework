import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/ob1.png"),
          const SizedBox(
            height: 70,
          ),
          Text(
            "Smart App Pengajuan Surat\nS-Kepuharjo akan mempermudahkan dalam proses pengajuan surat yang dilakukan oleh masyarakat.",
            textAlign: TextAlign.center,
            style: MyFont.poppins(fontSize: 12, color: black),
          )
        ],
      ),
    ));
  }
}
