import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ble-provider.dart';


void main() {
  if (Platform.isAndroid) {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterReactiveBle ble = FlutterReactiveBle();
  [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.locationAlways
    ].request().then((status) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BLEProvider(ble)),
      ],
      child: MyApp(),
    ),
  );
  });
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  int temperature = 0;
  String temperatureStr = "Hello";

  Future<bool> _onWillPop() async {
    print('will pop');
    return true;
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          Provider.of<BLEProvider>(context, listen: false).disconnect();
      return true;
    },
    child:Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xffffdf6f), Color(0xffeb2d95)])),
            child: Center(child: Consumer<BLEProvider>(
              builder: (context, ble, child) {
                return Text(
                  ble.message+" KG",
                  
                );
              },
            )))
        /*floatingActionButton: FloatingActionButton(
        onPressed: _connectBLE,
        tooltip: 'Increment',
        backgroundColor: Color(0xFF74A4BC),
        child: Icon(Icons.loop),
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}