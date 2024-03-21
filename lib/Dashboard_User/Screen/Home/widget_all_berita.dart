import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/custom_navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/detail_berita.dart';
import 'package:mobile_kepuharjo_new/Model/Berita.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  ApiServices apiServices = ApiServices();
  late Future<List<Berita>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getAllBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            "Semua Berita",
            style: MyFont.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Berita>>(
              future: listdata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  List<Berita>? data = snapshot.data;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      String dateTime = data[index].createdAt.toString();
                      final date = DateTime.parse(dateTime);
                      initializeDateFormatting('id_ID', null);
                      final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                      final timeFormat = DateFormat('HH:mm');
                      final formattedDate = dateFormat.format(date);
                      final formattedTime = timeFormat.format(date);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailBerita(berita: data[index]),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(Api.connectimage +
                                          data[index].image!.trim()),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data[index].judul.toString(),
                                  style: MyFont.poppins(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "$formattedDate  $formattedTime",
                                  style: MyFont.poppins(
                                      fontSize: 12,
                                      color: softgrey,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return ListView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CardLoading(
                              height: 120,
                              width: 150,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardLoading(
                                  height: 16,
                                  width: 100,
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CardLoading(
                                  height: 12,
                                  width: 160,
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CardLoading(
                                  height: 12,
                                  width: 160,
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.grey,
                                ),
                              ],
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }
                return ListView.builder(
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardLoading(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CardLoading(
                              height: 15,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CardLoading(
                              height: 10,
                              width: MediaQuery.of(context).size.width - 200,
                              borderRadius: BorderRadius.circular(8),
                            )
                          ],
                        ));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
