import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';

class TentangUser extends StatefulWidget {
  const TentangUser({super.key});

  @override
  State<TentangUser> createState() => _TentangUserState();
}

class _TentangUserState extends State<TentangUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          // centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Tentang Aplikasi",
              style: MyFont.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
              ),
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              "      S-kepuharjo merupakan aplikasi berbasis website dan mobile kepuharjo ini dapat digunakan oleh pihak masyarakat, RT, dan RW serta website khusus untuk pihak Admin Kelurahan yang digunakan untuk menampung surat sekaligus digunakan untuk data master dari masyarakat, dan diharapkan juga aplikasi pengajuan surat untuk masyarakat ini dapat dilakukan dimanapun dan kapanpun sehingga menjadi lebih efektif dan efisien.",
              style: MyFont.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.normal),
            ),
          ),
          // const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "     S-Kepuharjo termasuk upaya meningkatkan transparansi, kontrol serta akuntabilitas kinerja kelurahan dalam proses penanganan surat pengajuan dari masyarakat. Memperbaiki kualitas pelayanan publik untuk pengajuan surat pada tahap RT/RW, terutama dalam hal efektivitas dan efisiensi yang bisa memakan waktu berhari hari karena situasi pandemi. Mempermudah masyarakat dalam melakukan pengajuan berbagai macam jenis surat kepada pihak kelurahan",
              style: MyFont.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: Text(
              "Copyright © S-Kepuharjo 2023",
              style: MyFont.poppins(fontSize: 12, color: softgrey),
            ),
          ),
          const SizedBox(height: 30),
          Image.asset("images/gbr_tentang2.png"),
        ],
      )),
    );
  }
}
