import 'dart:async';
import 'package:convert/convert.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BLEProvider with ChangeNotifier {
  late FlutterReactiveBle _ble;
  StreamSubscription? _subscription;
  StreamSubscription<ConnectionStateUpdate>? _connection;
  String? _message;

  BLEProvider(FlutterReactiveBle ble) {
    _ble = ble;
    _connectBLE();
  }

  void _connectBLE() {
    _message = "Loading";
    notifyListeners();
    _subscription?.cancel();
    _subscription = _ble!.scanForDevices(withServices: [
      Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb")
    ]).listen((device) async {
      if (device.name == 'HCS23001') {
        print('HCS23001 found!');
        if (_connection != null) {
          try {
            await _connection!.cancel();
          } on Exception catch (e, _) {
            print("Error disconnecting from a device: $e");
            _message = e.toString();
            notifyListeners();
          }
        }
        _connection = _ble!
            .connectToDevice(
          id: device.id,
        )
            .listen((connectionState) async {
          // Handle connection state updates
          print('connection state:');
          print(connectionState.connectionState);
          if (connectionState.connectionState ==
              DeviceConnectionState.connected) {
            final characteristic = QualifiedCharacteristic(
                serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
                characteristicId:
                    Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
                deviceId: device.id);
            _ble.subscribeToCharacteristic(characteristic).listen((data) async {
              // print(data);

              String res = String.fromCharCodes(data);
              // print(res);
              // ||
              if (res.isNotEmpty && res.startsWith("ST")) {
                _message = "0000";
              } else if (res.isNotEmpty && res.startsWith("US") && res.endsWith("kg")) {
                print("Data is" + res);
                String trimmedString = res.substring(6,res.length - 2);
                
                _message = trimmedString;
              }
              // _message = String.fromCharCodes(data) + "kg";

              // _message = trimmedString;

              // print(String.fromCharCodes(data).split()); // Output: + 00000

              notifyListeners();
            }, onError: (dynamic error) {
              // code to handle errors
              print('error subscribing characteristic!');
              print(error.toString());
              _message = error.toString();
              notifyListeners();
            });

            // print('disconnected');
          }
        }, onError: (dynamic error) {
          // Handle a possible error
          print('error connecting!');
          print(error.toString());
          _message = error.toString();
          notifyListeners();
        });
      }
    }, onError: (error) {
      print('error scanning!');
      print(error.toString());
      _message = error.toString();
      notifyListeners();
    });
  }

  void disconnect() async {
    _subscription?.cancel();
    if (_connection != null) {
      await _connection!.cancel();
    }
  }

  String get message => _message.toString();
  StreamSubscription? get bleSubscription => _subscription;
}
