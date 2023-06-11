import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/detail_surat.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:date_format/date_format.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class SuratDitolakUser extends StatefulWidget {
  const SuratDitolakUser({super.key});

  @override
  State<SuratDitolakUser> createState() => _SuratDitolakUserState();
}

class _SuratDitolakUserState extends State<SuratDitolakUser> {
  ApiServices apiServices = ApiServices();
  late Future<List<Pengajuan>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getStatus("Ditolak RT");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pengajuan>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          List<Pengajuan>? data = snapshot.data;
          return Expanded(
            child: RefreshIndicator(
              color: lavender,
              onRefresh: () async {
                listdata = apiServices.getStatus("Ditolak RT");
              },
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 115,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "S-Kepuharjo",
                                    style: MyFont.poppins(
                                        fontSize: 10,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    formatDate(
                                      DateTime.parse(data[index].createdAt!),
                                      [dd, ' ', MM, ' ', yyyy],
                                    ),
                                    style: MyFont.poppins(
                                        fontSize: 10, color: softgrey),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red.withOpacity(0.2)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data[index].status.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    child: Image.network(
                                      Api.connectimage +
                                          data[index].surat!.image.toString(),
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      height: 40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]
                                                .masyarakat!
                                                .nik
                                                .toString(),
                                            style: MyFont.poppins(
                                                fontSize: 12,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data[index]
                                                .masyarakat!
                                                .namaLengkap
                                                .toString(),
                                            style: MyFont.poppins(
                                              fontSize: 12,
                                              color: black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailSurat(
                                                surat: data[index].surat!,
                                                pengajuan: data[index],
                                                masyarakat:
                                                    data[index].masyarakat!),
                                          ));
                                    },
                                    child: Icon(
                                      Icons.info_outline,
                                      color: lavender,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
    );
  }
}
