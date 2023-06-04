import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
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
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

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
    nokk.text = widget.keluarga.noKk.toString();
    nik.text = widget.masyarakat.nik.toString();
    nama.text = widget.masyarakat.namaLengkap.toString();
    ttl.text = widget.masyarakat.tempatLahir.toString() +
        DateFormat('dd MMMM yyyy')
            .format(DateTime.parse(widget.masyarakat.tglLahir.toString()));
    goldarah.text = widget.masyarakat.golonganDarah.toString();
    jk.text = widget.masyarakat.jenisKelamin.toString();
    kewarganegaraan.text = widget.masyarakat.kewarganegaraan.toString();
    agama.text = widget.masyarakat.agama.toString();
    statusperkawinan.text = widget.masyarakat.statusPerkawinan.toString();
    pekerjaan.text = widget.masyarakat.pekerjaan.toString();
    pendidikan.text = widget.masyarakat.pendidikan.toString();
    alamat.text = widget.keluarga.alamat.toString();
    rt.text = widget.keluarga.rt.toString();
    rw.text = widget.keluarga.rw.toString();
  }

  final nokk = TextEditingController();
  final nik = TextEditingController();
  final nama = TextEditingController();
  final ttl = TextEditingController();
  final goldarah = TextEditingController();
  final jk = TextEditingController();
  final kewarganegaraan = TextEditingController();
  final agama = TextEditingController();
  final statusperkawinan = TextEditingController();
  final pekerjaan = TextEditingController();
  final pendidikan = TextEditingController();
  final alamat = TextEditingController();
  final rt = TextEditingController();
  final rw = TextEditingController();
  final keperluan = TextEditingController();

  void verifypengajuan(BuildContext context) {
    if (keperluan.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Silahkan isi keperluan anda",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    } else if (imageKK == null) {
      Fluttertoast.showToast(
          msg: "Silahkan upload foto kartu keluarga anda",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    } else if (imageBukti == null) {
      Fluttertoast.showToast(
          msg: "Silahkan upload foto kartu keluarga anda",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    } else {
      showSuccessDialog(context, imageKK, imageBukti);
    }
  }

  // Future pengajuansurat() async {
  //   try {
  //     var res = await http.post(Uri.parse(Api.pengajuan), body: {
  //       "nik": widget.masyarakat.nik.toString(),
  //       "id_surat": widget.idsurat,
  //       "keterangan": keperluan.text,
  //     });
  //     final data = jsonDecode(res.body);
  //     if (res.statusCode == 200) {
  //       if (data['message'] == "Berhasil mengajukan surat") {
  //         // ignore: use_build_context_synchronously
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const DashboardUser(),
  //           ),
  //           (Route<dynamic> route) => false,
  //         ).then((value) {
  //           Fluttertoast.showToast(
  //               msg: "Berhasil mengajukan surat",
  //               backgroundColor: Colors.green,
  //               toastLength: Toast.LENGTH_LONG);
  //         });
  //       }
  //     } else {
  //       final data = jsonDecode(res.body);
  //       if (data['message'] == "Surat sebelumnya belum selesai") {
  //         MySnackbar(
  //                 type: SnackbarType.failed,
  //                 title:
  //                     "Mohon maaf, anda tidak bisa mengajukan surat , jika surat sebelumnya masih belum selesai")
  //             .showSnackbar(context);
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future pengajuan_surat(
      BuildContext context, File imageFileKK, File imageFileBukti) async {
    var uri = Uri.parse(Api.pengajuan);
    var req = http.MultipartRequest('POST', uri);

    // Menambahkan bagian (part) pertama untuk file imageFileKK
    var streamKK =
        http.ByteStream(DelegatingStream.typed(imageFileKK.openRead()));
    var lengthKK = await imageFileKK.length();
    var multipartFileKK = http.MultipartFile('image_kk', streamKK, lengthKK,
        filename: imageFileKK.path);
    req.files.add(multipartFileKK);

    // Menambahkan bagian (part) kedua untuk file imageFileBukti
    var streamBukti =
        http.ByteStream(DelegatingStream.typed(imageFileBukti.openRead()));
    var lengthBukti = await imageFileBukti.length();
    var multipartFileBukti = http.MultipartFile(
        'image_bukti', streamBukti, lengthBukti,
        filename: imageFileBukti.path);
    req.files.add(multipartFileBukti);

    req.fields['keterangan'] = keperluan.text;
    req.fields['id_surat'] = widget.idsurat;
    req.fields['nik'] = widget.masyarakat.nik.toString();

    var response = await req.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Berhasil mengajukan surat", backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(
          msg: "Gagal mengajukan surat", backgroundColor: Colors.green);
    }
  }

  showSuccessDialog(
      BuildContext context, File imageFileKK, File imageFileBukti) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, Jika data yang anda telah benar',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        pengajuan_surat(context, imageFileKK, imageFileBukti);
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  Future getImageGalerryKK() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageKK = File(imageFile!.path);
    });
  }

  Future getImageGalerryBukti() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageBukti = File(imageFile!.path);
    });
  }

  late File imageKK;
  late File imageBukti;
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
              controller: ttl,
              label: "Tempat, Tanggal Lahir",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: goldarah,
              label: "Golongan Darah",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: jk,
              label: "Jenis Kelamin",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: kewarganegaraan,
              label: "Kewarganegaraan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: agama,
              label: "Agama",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: statusperkawinan,
              label: "Status Perkawinan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: pekerjaan,
              label: "Pekerjaan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: pendidikan,
              label: "Pendidikan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: alamat,
              label: "Alamat",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: rt,
              label: "RT",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: rw,
              label: "RW",
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
            InkWell(
              onTap: () {
                getImageGalerryKK();
              },
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: lavender)),
                child: imageKK == null
                    ? Center(
                        child: Text(
                        'Upload Kartu Keluarga',
                        style: MyFont.poppins(fontSize: 12, color: black),
                      ))
                    : Image.file(
                        imageKK,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            InkWell(
              onTap: () {
                getImageGalerryBukti();
              },
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: lavender)),
                child: imageBukti == null
                    ? Center(
                        child: Text(
                        'Upload Bukti',
                        style: MyFont.poppins(fontSize: 12, color: black),
                      ))
                    : Image.file(
                        imageBukti,
                        fit: BoxFit.contain,
                      ),
              ),
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
                      verifypengajuan(context);
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
