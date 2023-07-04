import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/custom_navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';

class InformasiAkun extends StatefulWidget {
  const InformasiAkun({super.key});

  @override
  State<InformasiAkun> createState() => _InformasiAkunState();
}

class _InformasiAkunState extends State<InformasiAkun> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    // nik.text = user?.masyarakat?.nik.toString() ?? "";
  }

  Future<void> getUser() async {
    final authServices = AuthServices();
    final auth = await authServices.me();
    if (auth != null) {
      setState(() {
        user = auth;
        print("ok");
      });
    }
  }

  String formattedDate = "";

  @override
  Widget build(BuildContext context) {
    String? dateTime = user?.masyarakat?.tglLahir
        ?.toString(); // Tambahkan ? setelah tglLahir untuk mengatasi nullable
    if (dateTime != null) {
      final date = DateTime.parse(dateTime);
      initializeDateFormatting('id_ID', null);
      final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
      String formatted = dateFormat.format(date);
      setState(() {
        formattedDate = formatted;
      });
      // Gunakan formattedDate sesuai kebutuhan Anda
    } else {
      // Tindakan yang perlu diambil jika dateTime adalah null
    }

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Informasi Akun",
                  style: MyFont.poppins(
                      fontSize: 18, color: black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 50),
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(100)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/account.png",
                  color: white,
                )
              ],
            ),
          ),
          GetTextFieldUser(
            controller: TextEditingController(
                text: user?.masyarakat?.kks?.noKk.toString()),
            label: "No. Kartu Keluarga",
            keyboardType: TextInputType.number,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 16,
            icon: Icons.badge,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller:
                TextEditingController(text: user?.masyarakat?.nik.toString()),
            label: "Nomor Induk Kependudukan",
            keyboardType: TextInputType.number,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 16,
            icon: Icons.badge,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller: TextEditingController(
                text: user?.masyarakat?.namaLengkap.toString()),
            label: "Nama Lengkap",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 100,
            icon: Icons.person,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller: TextEditingController(text: user?.noHp.toString()),
            label: "No.Telepon",
            keyboardType: TextInputType.number,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.phone,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller: TextEditingController(
                text: "${user?.masyarakat?.tempatLahir}, $formattedDate"),
            label: "Tempat, Tanggal Lahir",
            keyboardType: TextInputType.number,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 100,
            icon: Icons.calendar_month,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller: TextEditingController(text: user?.masyarakat?.agama),
            label: "Agama",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.account_balance,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller:
                TextEditingController(text: user?.masyarakat?.pendidikan),
            label: "Pendidikan",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.school,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller:
                TextEditingController(text: user?.masyarakat?.pekerjaan),
            label: "Pekerjaan",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.work_outline_rounded,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller:
                TextEditingController(text: user?.masyarakat?.golonganDarah),
            label: "Golongan Darah",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.opacity,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller:
                TextEditingController(text: user?.masyarakat?.statusPerkawinan),
            label: "Status Perkawinan",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.people_rounded,
            isEnable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          GetTextFieldUser(
            controller:
                TextEditingController(text: user?.masyarakat?.kewarganegaraan),
            label: "Kewarganegaraan",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            length: 15,
            icon: Icons.language,
            isEnable: false,
          ),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}
