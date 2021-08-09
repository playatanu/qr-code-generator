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
    Scan(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("QR CODE"),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _navIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_scanner,
                ),
                // ignore: deprecated_member_use
                title: Text('Scan QR'),
                activeIcon: Icon(Icons.qr_code_scanner),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code,
                ),
                // ignore: deprecated_member_use
                title: Text('QR Code'),
                activeIcon: Icon(
                  Icons.qr_code,
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
