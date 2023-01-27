import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class select_start extends StatefulWidget {
  // double startlat;
  // double startlng;
  select_start({Key? key}) : super(key: key);
  @override
  State<select_start> createState() => _select_startState();
}

class _select_startState extends State<select_start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          center: LatLong(startlat,startlng),
          buttonColor: Colors.blue,
          buttonText: 'Set start location',
          onPicked: (pickedData) {
            setState(() {
              startlat = pickedData.latLong.latitude;
              startlng = pickedData.latLong.longitude;
              Navigator.pop(context);
            });
          }),
    );
  }
}
