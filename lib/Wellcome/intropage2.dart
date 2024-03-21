import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/ob2.png"),
          const SizedBox(
            height: 70,
          ),
          Text(
            "S-Tompokersan juga memuat berbagai\ninformasi dan berita terkini mengenai Kelurahan Kepuharjo,mulai dari berita terbaru tentang kegiatan masyarakat, kondisi lingkungan, hingga pengumuman pemerintah setempat.",
            textAlign: TextAlign.center,
            style: MyFont.poppins(fontSize: 12, color: black),
          )
        ],
      ),
    ));
  }
}
