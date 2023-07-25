import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/info_surat.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SuratDibatalkanUser extends StatefulWidget {
  const SuratDibatalkanUser({super.key});

  @override
  State<SuratDibatalkanUser> createState() => _SuratDibatalkanUserState();
}

class _SuratDibatalkanUserState extends State<SuratDibatalkanUser> {
  ApiServices apiServices = ApiServices();
  late Future<List<Pengajuan>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getStatus("Dibatalkan");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            "Surat Dibatalkan",
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
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            FutureBuilder<List<Pengajuan>>(
              future: listdata,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<Pengajuan>? data = snapshot.data;
                  return RefreshIndicator(
                    color: lavender,
                    onRefresh: () async {
                      listdata = apiServices.getStatus("Dibatalkan");
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: data!.length,
                      physics: NeverScrollableScrollPhysics(),
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
                                  builder: (context) => InfoSurat(
                                      surat: data[index].surat!,
                                      pengajuan: data[index],
                                      masyarakat: data[index].masyarakat!),
                                ));
                          },
                          child: Container(
                            height: 120,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "S-Kepuharjo",
                                            style: MyFont.poppins(
                                                fontSize: 10,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "$formattedDate  $formattedTime",
                                            style: MyFont.poppins(
                                                fontSize: 10, color: softgrey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.red),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index].status.toString(),
                                              style: MyFont.poppins(
                                                  fontSize: 10,
                                                  color: white,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: primaryColor
                                                    .withOpacity(0.1)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  Api.connectimage +
                                                      data[index]
                                                          .surat!
                                                          .image
                                                          .toString(),
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                    builder: (context) =>
                                                        InfoSurat(
                                                            surat: data[index]
                                                                .surat!,
                                                            pengajuan:
                                                                data[index],
                                                            masyarakat: data[
                                                                    index]
                                                                .masyarakat!),
                                                  ));
                                            },
                                            child: Icon(
                                              Icons.info_outline_rounded,
                                              color: black,
                                            ),
                                          )),
                                    ],
                                  ),
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
                    itemCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: CardLoading(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  );
                }
                return ListView.builder(
                  itemCount: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: CardLoading(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
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
