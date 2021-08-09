import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final key = GlobalKey();
  File? file;
  TextEditingController _nameControler = TextEditingController();
  String imgUrl = "";
  String qrData = "controller";
  String qrLable = "PLAYATANU";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.zero),
                    child: RepaintBoundary(
                      key: key,
                      child: QrImage(
                        backgroundColor: Colors.white,
                        data: qrData,
                        version: QrVersions.auto,
                        size: 200.0,
                        semanticsLabel: qrLable,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "PLAYATANU",
                    style: TextStyle(backgroundColor: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _nameControler,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      labelText: 'Enter a message',
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 2, color: Colors.blue),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            width: 1,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: Colors.blue)),
                      suffixIcon: IconButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            qrData = _nameControler.text;
                          });
                        },
                        icon: Icon(Icons.check),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // ignore: deprecated_member_use
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () async {
                        try {
                          RenderRepaintBoundary boundary = key.currentContext!
                              .findRenderObject() as RenderRepaintBoundary;
//captures qr image
                          var image = await boundary.toImage();
                          ByteData? byteData = await image.toByteData(
                              format: ImageByteFormat.png);
                          Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
                          final appDir =
                              await getApplicationDocumentsDirectory();
//current time
                          var datetime = DateTime.now();
//qr image file creation
                          file = await File('${appDir.path}/$datetime.png')
                              .create();
//appending data
                          await file?.writeAsBytes(pngBytes);
//Shares QR image
                          await Share.shareFiles(
                            [file!.path],
                            mimeTypes: ["image/png"],
                            text: "Hello PLAYATANU",
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Share QR CODE',
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
                  ),
                  // ignore: deprecated_member_use
                ],
              ),
            )),
      ),
    );
  }
}
