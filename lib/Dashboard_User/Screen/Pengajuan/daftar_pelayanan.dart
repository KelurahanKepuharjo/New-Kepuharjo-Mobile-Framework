import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Pengajuan/daftar_keluarga.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class Layanan extends StatefulWidget {
  const Layanan({super.key});

  @override
  State<Layanan> createState() => _LayananState();
}

class _LayananState extends State<Layanan> {
  ApiServices apiServices = ApiServices();
  late Future<List<Surat>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getSurat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          // centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Jenis Surat",
              style: MyFont.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              RefreshIndicator(
                color: lavender,
                onRefresh: () async {
                  listdata = apiServices.getSurat();
                },
                child: FutureBuilder<List<Surat>>(
                  future: listdata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      List<Surat>? data = snapshot.data;
                      return SizedBox(
                          child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DaftarKeluarga(
                                              selectedSurat: data[index]),
                                        ));
                                  },
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      Api.connectimage +
                                          data[index].image.toString(),
                                    ),
                                  ),
                                  title: Text(
                                    "Surat Keterangan",
                                    style: MyFont.poppins(
                                        fontSize: 13,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data[index].namaSurat.toString(),
                                    style: MyFont.poppins(
                                        fontSize: 12, color: black),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: black,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ));
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
              )
            ],
          ),
        ));
  }
}
