import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/ob3.png"),
          const SizedBox(
            height: 70,
          ),
          Text(
            "S-Kepuharjo memiliki terdiri dari 2 platform. Website untuk admin kelurahan, aplikasi android untuk masyarakat dan ketua RT dan ketua RW. Aplikasi android memungkinkan pengguna mengakses berita terkini dan melakukan pengajuan surat dengan praktis.",
            textAlign: TextAlign.center,
            style: MyFont.poppins(fontSize: 12, color: black),
          )
        ],
      ),
    ));
  }
}
