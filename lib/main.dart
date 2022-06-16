import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcodegenerator/AppConstant.dart' as AppConstant;

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'QR Code Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();

  String textToConvert = "";
  String qrType = AppConstant.dropDownList.first;

  GlobalKey imageCaptureKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DropdownButton(
                          items: AppConstant.dropDownList.map((item) {
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            );
                          }).toList(),
                          value: qrType,
                          isExpanded: true,
                          onChanged: (data) {
                            qrType = data;
                            setState(() {});
                          }),
                      Container(
                          height: 150,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)),
                          child: TextField(
                            controller: textEditingController,
                            maxLines: 5,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          )),
                      Padding(padding: const EdgeInsets.all(10.0)),
                      RaisedButton(
                        onPressed: () {
                          if (qrType == AppConstant.dropDownList[1]) {
                            textToConvert = "tel:${textEditingController.text}";
                          } else
                            textToConvert = "${textEditingController.text}";

                          setState(() {});
                        },
                        color: Colors.blueGrey,
                        child: Text(
                          "CONVERT",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(10.0)),
                    RepaintBoundary(
                      key: imageCaptureKey,
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: textToConvert,
                          version: QrVersions.auto,
                          size: 200,
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                  ],
                ),
              )),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
