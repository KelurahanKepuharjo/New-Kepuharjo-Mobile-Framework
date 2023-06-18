import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/info_surat.dart';

import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:date_format/date_format.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class SuratSelesaiUser extends StatefulWidget {
  const SuratSelesaiUser({super.key});

  @override
  State<SuratSelesaiUser> createState() => _SuratSelesaiUserState();
}

class _SuratSelesaiUserState extends State<SuratSelesaiUser>
    with SingleTickerProviderStateMixin {
  ApiServices apiServices = ApiServices();
  late Future<List<Pengajuan>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getStatus("Selesai");
  }

  List<bool> _isVisible = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pengajuan>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          List<Pengajuan>? data = snapshot.data;
          if (_isVisible.length == 0) {
            for (int i = 0; i < data!.length; i++) {
              _isVisible.add(false);
            }
          }
          return Expanded(
            child: RefreshIndicator(
              color: lavender,
              onRefresh: () async {
                listdata = apiServices.getStatus("Selesai");
              },
              child: ListView.builder(
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
                      setState(() {
                        _isVisible[index] = !_isVisible[index];
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn,
                      height: _isVisible[index] ? 172 : 120,
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
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.green),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: primaryColor.withOpacity(0.1)),
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
                                        setState(() {
                                          _isVisible[index] =
                                              !_isVisible[index];
                                        });
                                      },
                                      child: Icon(
                                        _isVisible[index]
                                            ? Icons.keyboard_arrow_down_rounded
                                            : Icons
                                                .keyboard_arrow_right_rounded,
                                        color: lavender,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastOutSlowIn,
                            vsync: this,
                            child: Visibility(
                              visible: _isVisible[index],
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      height: _isVisible[index] ? 40 : 0,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              )),
                                          onPressed: () {
                                            // verifyLogin();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'images/pdf.png',
                                                    color: white,
                                                    height: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text('Unduh Surat',
                                                      style: MyFont.poppins(
                                                          fontSize: 12,
                                                          color: white)),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      height: _isVisible[index] ? 40 : 0,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              )),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InfoSurat(
                                                          surat: data[index]
                                                              .surat!,
                                                          pengajuan:
                                                              data[index],
                                                          masyarakat:
                                                              data[index]
                                                                  .masyarakat!),
                                                ));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.info_outline_rounded,
                                                    color: white,
                                                    size: 27,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text('Info Surat',
                                                      style: MyFont.poppins(
                                                          fontSize: 12,
                                                          color: white)),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
