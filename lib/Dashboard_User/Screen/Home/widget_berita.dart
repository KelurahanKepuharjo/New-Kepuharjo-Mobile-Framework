import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/detail_berita.dart';
import 'package:mobile_kepuharjo_new/Model/Berita.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class WidgetBerita extends StatefulWidget {
  const WidgetBerita({Key? key}) : super(key: key);

  @override
  State<WidgetBerita> createState() => _WidgetBeritaState();
}

class _WidgetBeritaState extends State<WidgetBerita> {
  ApiServices apiServices = ApiServices();
  late Future<List<Berita>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getBerita();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.only(left: 8.0),
      child: FutureBuilder<List<Berita>>(
        future: listdata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Berita>? data = snapshot.data;
            return Container(
              margin: EdgeInsets.only(right: 15),
              // height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailBerita(berita: data[index]),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                width: 150,
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
                              Expanded(
                                // width: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].judul.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      data[index].subTitle.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 12,
                                          color: softgrey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      data[index].deskripsi.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
        },
      ),
    );
  }
}
