import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class select_destination extends StatefulWidget {
  const select_destination({Key? key}) : super(key: key);
  @override
  State<select_destination> createState() => _select_destinationState();
}
double destiLat = 19.0760;
double destiLng = 72.8777;
class _select_destinationState extends State<select_destination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          center: LatLong(destiLat, destiLng),
          buttonColor: Colors.blue,
          buttonText: 'Set destination location',
          onPicked: (pickedData) {
            setState(() {
              destiLat = pickedData.latLong.latitude;
              destiLng = pickedData.latLong.longitude;
              Navigator.pop(context);
            });
          }),
    );
  }
}
