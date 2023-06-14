import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Pengajuan/daftar_keluarga.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:provider/provider.dart';

class WidgetPelayanan extends StatefulWidget {
  const WidgetPelayanan({Key? key}) : super(key: key);

  @override
  State<WidgetPelayanan> createState() => _WidgetPelayananState();
}

class _WidgetPelayananState extends State<WidgetPelayanan> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Layanan Pengajuan Surat Keterangan",
                    style: MyFont.poppins(
                        fontSize: 13,
                        color: black,
                        fontWeight: FontWeight.w500)),
                Text("Berbagai layanan pengajuan surat keterangan",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: softgrey,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: FutureBuilder<List<Surat>>(
              future: listdata,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Surat>? isiData = snapshot.data;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: isiData!.length > 8 ? 8 : isiData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            mainAxisExtent: 100),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DaftarKeluarga(
                                  selectedSurat: isiData[index],
                                ),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: SizedBox(
                                height: 60,
                                child: index < isiData.length
                                    ? Image.network(
                                        Api.connectimage +
                                            isiData[index].image.toString(),
                                      )
                                    : SizedBox(),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(isiData[index].namaSurat.toString(),
                                  textAlign: TextAlign.center,
                                  style: MyFont.poppins(
                                      fontSize: 11, color: black)),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.data}");
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: blue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
