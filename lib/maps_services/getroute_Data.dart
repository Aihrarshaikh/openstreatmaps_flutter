import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_route_service/open_route_service.dart';

late final List<LatLng> routePoints;
Future mapp(
    double startLat,
    double startlng,
    double endlat,
    double endlng,
    ) async {
  final OpenRouteService client = OpenRouteService(apiKey: '5b3ce3597851110001cf62484df0bf4827b74ded8b68ccd2d5c570d1');
  final List<ORSCoordinate> routeCoordinates =
  await client.directionsRouteCoordsGet(
    startCoordinate: ORSCoordinate(latitude: startLat, longitude: startlng),
    endCoordinate: ORSCoordinate(latitude: endlat, longitude: endlng),
  );
  // routeCoordinates.forEach(print);
  // return routeCoordinates;
  List<LatLng> routePoints = routeCoordinates
      .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
      .toList();
  final Polyline routePolyline = Polyline(
    polylineId: PolylineId('route'),
    visible: true,
    points: routePoints,
    color: Colors.red,
    width: 4,
  );
  GeoCode geoCode = GeoCode();
  routePoints.forEach((element) async { try {
    Address address = await geoCode.reverseGeocoding(latitude: element.latitude, longitude: element.longitude);
    Future.delayed(Duration(milliseconds: 200));
    print(" ${address.region} , ${address.streetAddress}");
  } catch (e) {
    // print(e);
  }});
  // try {
  //   Address address = await geoCode.reverseGeocoding(latitude: 0.0, longitude: 0.0)
  //   print("Latitude: ${address.city} , ${address.region}");
  // } catch (e) {
  //   print(e);
  // }
  // routePoints.forEach((element) async{
  //   final coordinates = new Coordinates(element.latitude, element.longitude);
  //  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //  var first = addresses.first;
  //   print("${first.featureName} : ${first.addressLine}");
  // });

}