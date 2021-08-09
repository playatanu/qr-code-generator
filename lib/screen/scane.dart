import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanBarcode = ' ';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                padding: EdgeInsets.all(18),
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                        size: 40,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "Please move your camera over another device's screen",

                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Lottie.asset(
                        'assets/qrcode.json',
                        width: 180,
                        height: 180,
                        fit: BoxFit.fill,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: scanQR,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Scan QR CODE',
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ), // ignore: deprecated_member_use
                      SizedBox(
                        height: 20,
                      ),
                      Text('$_scanBarcode\n'),
                    ])),
          ],
        ),
      ),
    ));
  }
}

// Text('Scan result : $_scanBarcode\n')