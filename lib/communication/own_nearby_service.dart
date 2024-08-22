import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:myapp/utils/constants/app_constants.dart';

class OwnNearbyService {
  final String userName;
  final DeviceType deviceType;
  List<Device> devices = [];
  NearbyService? nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;

  OwnNearbyService({
    required this.deviceType,
    required this.userName,
  });

  Future<void> initNearbyService() async {
    nearbyService = NearbyService();
    await nearbyService!.init(
        deviceName: userName,
        serviceType: 'mpconn',
        strategy: Strategy.P2P_POINT_TO_POINT,
        callback: (isRunning) async {
          debugPrint('Callback $isRunning');
          nearbyService!.stateChangedSubscription(callback: (deviceList) {
            debugPrint('Start StateChangeListener');
            devices.clear();
            for (Device device in deviceList) {
              devices.add(device);
              debugPrint('New Device: ${device.deviceId}');
            }
          });
          nearbyService!.dataReceivedSubscription(
            callback: (data) {
              debugPrint(data);
              handleReceivedData(data);
            },
          );
          debugPrint('Device List: $devices');
          if (deviceType == DeviceType.browser) {
            await nearbyService!.stopBrowsingForPeers();
            Future.delayed(
              const Duration(
                milliseconds: 500,
              ),
            );
            var resultBrowsing = await nearbyService!.startBrowsingForPeers();
            debugPrint('Result Browsing: $resultBrowsing');
          } else {
            await nearbyService!.startAdvertisingPeer();
            Future.delayed(
              const Duration(
                milliseconds: 500,
              ),
            );
            var resultAdvertising = await nearbyService!.startAdvertisingPeer();
            debugPrint('Result Advertising: $resultAdvertising');
          }
        });
  }

  void handleReceivedData(String data) {
    final receivedData = jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> connectToDevice(
      String otherDeviceName, String otherDeviceId) async {
    var result = await nearbyService!.invitePeer(
      deviceID: otherDeviceId,
      deviceName: otherDeviceName,
    );
    debugPrint('Connection Result: $result');
  }

  void sendData(Map<String, dynamic> data, String deviceID) {
    nearbyService!.sendMessage(
      deviceID,
      jsonEncode(data),
    );
  }

  void disconnectDevice(String deviceID) {
    nearbyService!.disconnectPeer(deviceID: deviceID);
  }
}
