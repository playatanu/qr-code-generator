import 'package:bro_code/screen/home.dart';
import 'package:bro_code/screen/scane.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _navIndex = 0;

  List<Widget> _widgetList = <Widget>[
    Home(),
    // QRViewExample(),
    Scan(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bro Code"),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _navIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code,
                  //color: kGoodLightGray,
                ),
                // ignore: deprecated_member_use
                title: Text('CALENDAR'),
                activeIcon: Icon(
                  Icons.qr_code,
                  // color: kGoodPurple,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_scanner,
                  //color: kGoodLightGray,
                ),
                // ignore: deprecated_member_use
                title: Text('CALENDAR'),
                activeIcon: Icon(Icons.qr_code_scanner
                    // color: kGoodPurple,
                    ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _navIndex = index;
              });
            }),
        body: _widgetList.elementAt(_navIndex),
      ),
    );
  }
}
