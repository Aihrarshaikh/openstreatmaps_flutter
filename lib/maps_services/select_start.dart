import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:flutter/material.dart';

class select_start extends StatefulWidget {
  const select_start({Key? key}) : super(key: key);
  @override
  State<select_start> createState() => _select_startState();
}
double startLat = 18.5204;
double startLng = 73.8567;
class _select_startState extends State<select_start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          center: LatLong(startLat, startLng),
          buttonColor: Colors.blue,
          buttonText: 'Set start location',
          onPicked: (pickedData) {
            setState(() {
              startLat = pickedData.latLong.latitude;
              startLng = pickedData.latLong.longitude;
              Navigator.pop(context);
            });
          }),
    );
  }
}
