import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';

class WidgetTextBerita extends StatelessWidget {
  const WidgetTextBerita({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
            )
          ]),
    );
  }
}
