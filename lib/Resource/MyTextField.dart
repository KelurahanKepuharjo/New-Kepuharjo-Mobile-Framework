import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class GetTextFieldUser extends StatefulWidget {
  TextEditingController controller;
  String label;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  int length;
  IconData icon;
  bool isEnable;
  TextInputAction textInputAction;
  GetTextFieldUser(
      {Key? key,
      required this.controller,
      required this.label,
      required this.keyboardType,
      this.isEnable = true,
      required this.inputFormatters,
      required this.length,
      required this.icon,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<GetTextFieldUser> createState() => _GetTextFieldUserState();
}

class _GetTextFieldUserState extends State<GetTextFieldUser> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.icon,
          size: 25,
          color: grey,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: TextFormField(
            enabled: widget.isEnable,
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            style: MyFont.poppins(fontSize: 13, color: black),
            keyboardType: widget.keyboardType,
            inputFormatters: [
              widget.inputFormatters,
              LengthLimitingTextInputFormatter(widget.length)
            ],
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: MyFont.poppins(fontSize: 13, color: grey),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: grey)),
            ),
          ),
        ),
      ],
    );
  }
}
