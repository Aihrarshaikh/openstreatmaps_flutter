import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../main.dart';

class select_destination extends StatefulWidget {
  // double destilat;
  // double destilng;
  select_destination({Key? key,}) : super(key: key);
  @override
  State<select_destination> createState() => _select_destinationState();
}
class _select_destinationState extends State<select_destination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          center: LatLong(destilat, destilng),
          buttonColor: Colors.blue,
          buttonText: 'Set destination location',
          onPicked: (pickedData) {
            setState(() {
              destilat = pickedData.latLong.latitude;
             destilng = pickedData.latLong.longitude;
              Navigator.pop(context);
            });
          }),
    );
  }
}
