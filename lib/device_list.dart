import "package:flutter/material.dart";
import "package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart";

import "device.dart";
import "util.dart";

class DeviceList extends StatelessWidget {

  final Key key;
  final BluetoothState state;
  final List<BluetoothDevice> devices;
  final DeviceSelectionCallback onDeviceSelected;

  DeviceList({
    this.key,
    @required this.state,
    @required this.devices,
    @required this.onDeviceSelected
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    // Displays a warning message in case bluetooth receiver
    // is off
    if (state != BluetoothState.STATE_ON) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.bluetooth_disabled),
            onPressed: FlutterBluetoothSerial.instance.requestEnable,
            iconSize: 72,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 12.0),
            child: Text(
              "Your bluetooth seems to be disabled. Tap on the icon above to turn it on",
              textAlign: TextAlign.center,
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2)
            ),
          ),
        ],
      );
    } else {
      return ListView.separated(
        itemBuilder: (BuildContext context, int index) => Device(
          device: devices[index],
          onTap: onDeviceSelected,
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: devices.length
      );
    }
  }
}