import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IosNative extends StatefulWidget {
  const IosNative({super.key});

  @override
  State<IosNative> createState() => _IosNativeState();
}

class _IosNativeState extends State<IosNative> {
  Device? _device;

  Future<void> getDeviceInfo() async {
    const MethodChannel _channel = MethodChannel('ios/deviceInfo');

    try {
      final Map<String, dynamic> userMap = Map<String, dynamic>.from(
        await _channel.invokeMethod('getDeviceInfo'),
      );
      final device = Device.fromMap(userMap);
      setState(() {
        _device = device;
      });
    } on PlatformException catch (e) {
      print("Failed to get device info: '${e.message}'.");
    }
  }

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Native Code")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(" Device Name:  ${_device?.modelName ?? ''}"),
            Text("Device Version:  ${_device?.version ?? ''}"),
          ],
        ),
      ),
    );
  }
}

class Device {
  final String modelName;
  final String version;

  Device({required this.modelName, required this.version});

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(modelName: map['modelName'], version: map['version']);
  }
}
