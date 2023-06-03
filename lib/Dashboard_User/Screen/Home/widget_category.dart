import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_berita.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_pelayanan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_text_berita.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Expanded(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            WidgetPelayanan(),
            WidgetTextBerita(),
            WidgetBerita(),
          ],
        ),
      )),
    );
  }
}
