import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Model/Keluarga.dart';
import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';
import 'package:mobile_kepuharjo_new/Resource/MySnackbar.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField_Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';

class Pengajuansurat extends StatefulWidget {
  String idsurat;
  String namaSurat;
  Keluarga keluarga;
  Masyarakat masyarakat;
  Pengajuansurat(
      {Key? key,
      required this.idsurat,
      required this.namaSurat,
      required this.keluarga,
      required this.masyarakat})
      : super(key: key);

  @override
  State<Pengajuansurat> createState() => _PengajuansuratState();
}

class _PengajuansuratState extends State<Pengajuansurat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nik.text = widget.masyarakat.nik.toString();
    nokk.text = widget.keluarga.noKk.toString();
    nama.text = widget.masyarakat.namaLengkap.toString();
  }

  final nik = TextEditingController();
  final nama = TextEditingController();
  final nokk = TextEditingController();
  final alamat = TextEditingController();
  final rt = TextEditingController();
  final rw = TextEditingController();
  final ttl = TextEditingController();
  final jk = TextEditingController();
  final pendidikan = TextEditingController();
  final agama = TextEditingController();
  final keperluan = TextEditingController();

  void verifypengajuan() {
    if (keperluan.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Silahkan isi keperluan anda",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    } else {
      showSuccessDialog(context);
    }
  }

  Future pengajuansurat() async {
    try {
      var res = await http.post(Uri.parse(Api.pengajuan), body: {
        "nik": widget.masyarakat.nik.toString(),
        "id_surat": widget.idsurat,
        "keterangan": keperluan.text,
      });
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "Berhasil mengajukan surat") {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardUser(),
            ),
            (Route<dynamic> route) => false,
          ).then((value) {
            Fluttertoast.showToast(
                msg: "Berhasil mengajukan surat",
                backgroundColor: Colors.green,
                toastLength: Toast.LENGTH_LONG);
          });
        }
      } else {
        final data = jsonDecode(res.body);
        if (data['message'] == "Surat sebelumnya belum selesai") {
          MySnackbar(
                  type: SnackbarType.failed,
                  title:
                      "Mohon maaf, anda tidak bisa mengajukan surat , jika surat sebelumnya masih belum selesai")
              .showSnackbar(context);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, Jika data yang anda masukan telah benar',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        pengajuansurat();
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: lavender,
          shadowColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Pengajuan Surat",
            style: MyFont.poppins(
                fontSize: 16, color: white, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: white,
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
              child: Text(
                "Pengajuan Surat Keterangan ${widget.namaSurat}",
                style: MyFont.poppins(
                    fontSize: 13, color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 20),
              child: Text(
                "Silahkan pastikan bahwa semua data anda sudah terisi semua",
                style: MyFont.poppins(
                    fontSize: 11, color: black, fontWeight: FontWeight.normal),
              ),
            ),
            GetTextFieldPengajuan(
                controller: nokk,
                label: "No. Kartu Keluarga",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            GetTextFieldPengajuan(
              controller: nik,
              label: "No. Induk Keluarga",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: nama,
              label: "Nama Lengkap",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: keperluan,
              label: "Keperluan",
              isEnable: true,
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: lavender,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () async {
                      verifypengajuan();
                    },
                    child: Text('Ajukan Surat',
                        textAlign: TextAlign.center,
                        style: MyFont.poppins(fontSize: 14, color: white)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
