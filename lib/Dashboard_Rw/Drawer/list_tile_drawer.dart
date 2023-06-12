import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function() onTap;

  CollapsingListTile(
      {required this.title,
      required this.icon,
      required this.isSelected,
      required this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? selectedColor : Colors.white30,
              size: 20.0,
            ),
            const SizedBox(width: 10),
            Text(widget.title,
                style: widget.isSelected
                    ? MyFont.poppins(
                        fontSize: 13,
                        color: white,
                        fontWeight: FontWeight.normal)
                    : MyFont.poppins(
                        fontSize: 13,
                        color: Colors.white70,
                        fontWeight: FontWeight.normal)),
            ListTile()
          ],
        ),
      ),
    );
  }
}
