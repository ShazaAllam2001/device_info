import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deviceModel = "";
  String osVersion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Device Model: $deviceModel',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'OS Version: $osVersion',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          try {
            if (Theme.of(context).platform == TargetPlatform.iOS) {
              IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
              setState(() {
                deviceModel = iosInfo.utsname.machine;
                osVersion = iosInfo.systemVersion;
              });
            } 
            else if (Theme.of(context).platform == TargetPlatform.android) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              setState(() {
                deviceModel = androidInfo.model;
                osVersion = androidInfo.version.release;
              });
            }
          }
          catch (e) {
            setState(() {
              deviceModel = 'Failed to get device info';
              osVersion = 'Failed to get OS version';
            });
          }
        },
        child: Icon(Icons.devices)
      ),
    );
  }
}
