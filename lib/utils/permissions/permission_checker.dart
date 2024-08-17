import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {
  
  static Future<bool> checkBluetoothScan()async{
    return Permission.bluetoothScan.request().then((value) => value == PermissionStatus.granted);
    }

  static Future<bool> checkBluetoothConnect()async{
    return Permission.bluetoothConnect.request().then((value) => value == PermissionStatus.granted);
    }

  static Future<bool> checkLocation()async{
    return Permission.location.request().then((value) => value == PermissionStatus.granted);
    }

  static Future<bool> checkBluetoothAdvertise()async{
    return Permission.bluetoothAdvertise.request().then((value) => value == PermissionStatus.granted);
    }

  static Future<bool> checkNearbyWifiConnection(){
    return Permission.nearbyWifiDevices.request().then((value) => value == PermissionStatus.granted);
  }

  static Future<bool> checkBluetooth()async{
    return Permission.bluetooth.request().then((value) => value == PermissionStatus.granted);
    }

  static Future<bool> checkAllPermissions()async{
    return await checkBluetoothScan() && await checkBluetoothConnect() && await checkLocation() && await checkBluetoothAdvertise() && await checkNearbyWifiConnection() && await checkBluetooth();
  }
  }
