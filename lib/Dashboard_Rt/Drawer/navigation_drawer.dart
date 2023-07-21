import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'select.dart';

import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemClicked;
  const CollapsingNavigationDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onItemClicked,
  }) : super(key: key);
  @override
  CollapsingNavigationDrawerState createState() {
    return CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  late SharedPreferences prefs;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  void _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      currentSelectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    saveSharedPreferences(currentSelectedIndex);
    super.dispose();
  }

  void saveSharedPreferences(int index) async {
    await prefs.setInt('selectedIndex', index);
  }

  void navigateTo(int index) {
    Provider.of<SelectedPage>(context, listen: false).selectedIndex = index;
    setState(() {
      currentSelectedIndex = index;
    });
    widget.onItemClicked(index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context, widget);
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 80.0,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade600,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: ListTile(
                  leading: Image.asset(
                    "images/mylogo.png",
                    height: 40,
                  ),
                  title: Text(
                    "S-Kepuharjo",
                    style: MyFont.poppins(
                        fontSize: 18,
                        color: white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(height: 12.0);
                },
                itemBuilder: (context, index) {
                  final NavigationModel item = navigationItems[index];
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentSelectedIndex == index
                            ? Colors.transparent.withOpacity(0.3)
                            : Colors.transparent,
                      ),
                      child: ListTile(
                        leading: Icon(
                          item.icon,
                          color: currentSelectedIndex == index
                              ? selectedColor
                              : Colors.white30,
                          size: 20.0,
                        ),
                        title: Text(item.title,
                            style: currentSelectedIndex == index
                                ? MyFont.poppins(
                                    fontSize: 13,
                                    color: white,
                                    fontWeight: FontWeight.normal)
                                : MyFont.poppins(
                                    fontSize: 13,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.normal)),
                        selected: currentSelectedIndex == index,
                        onTap: () {
                          setState(() {
                            currentSelectedIndex = index;
                            saveSharedPreferences(index);
                          });
                          navigateTo(index);
                        },
                      ));
                },
                itemCount: navigationItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
