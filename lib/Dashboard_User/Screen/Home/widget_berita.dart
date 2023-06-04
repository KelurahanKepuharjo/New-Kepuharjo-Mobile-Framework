import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FutureBuilder<List<Berita>>(
        future: listdata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Berita>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(Api.connectimage +
                                      data[index].image!.trim()),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 125,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].judul.toString(),
                                style: MyFont.poppins(
                                    fontSize: 13,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data[index].subTitle.toString(),
                                style: MyFont.poppins(
                                    fontSize: 11,
                                    color: black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(
              color: blue,
            ),
          );
        },
      ),
    );
  }
}
