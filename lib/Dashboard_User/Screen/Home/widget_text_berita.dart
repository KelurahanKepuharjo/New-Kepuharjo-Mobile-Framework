import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_all_berita.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';

class WidgetTextBerita extends StatelessWidget {
  const WidgetTextBerita({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10, 0, 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Berita Terkini",
                      style: MyFont.poppins(
                          fontSize: 13,
                          color: black,
                          fontWeight: FontWeight.w500)),
                  Text("Berbagai berita terkait kelurahan kepuharjo",
                      style: MyFont.poppins(
                          fontSize: 12,
                          color: softgrey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllNews(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Text("Lihat Semua",
                    style: MyFont.poppins(
                        fontSize: 13,
                        color: black,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ]),
    );
  }
}
