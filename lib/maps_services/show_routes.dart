import 'dart:async';
import 'dart:core';
import 'package:biker_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
class PolylinePage extends StatefulWidget {
 // late Future<List<Polyline>> polylines;
 //  double startlat;
 //  double startlng;
 //  double endlat;
 //  double endlng;
 // List<LatLng> routePoints;
  PolylinePage({Key? key}) : super(key: key);
  @override
  State<PolylinePage> createState() => _PolylinePageState();
}
class _PolylinePageState extends State<PolylinePage> {
  Future<List<Polyline>> getPolylines() async {
    final OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf62484df0bf4827b74ded8b68ccd2d5c570d1');
    final List<ORSCoordinate> routeCoordinates =
    await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(
          latitude: startlat, longitude: startlng),
      endCoordinate: ORSCoordinate(
          latitude: destilat, longitude: destilng),
    );
    setState(() {routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();});
    final polyLines = [
      Polyline(
        points: routePoints,
        strokeWidth: 4,
        color: Colors.blueAccent,
      ),
    ];
    await Future<void>.delayed(const Duration(seconds: 3));
    return polyLines;
  }
  @override
  void initState() {
    polylines = getPolylines();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final points = routePoints;
    final pointsGradient = routePoints;
    return Scaffold(
      // appBar: AppBar(title: const Text('Polylines')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<Polyline>>(
            future: polylines,
            builder:
                (BuildContext context, AsyncSnapshot<List<Polyline>> snapshot) {
                  debugPrint('snapshot: ${snapshot.data}');
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Text('Polylines'),
                        ),
                        Flexible(
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(startlat, startlng),
                              zoom: 15,
                              onTap: (tapPosition, point) {
                                setState(() {
                                  // debugPrint('onTap');
                                  // polylines = getPolylines();
                                });
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                              ),
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                      points: points,
                                      strokeWidth: 4,
                                      color: Colors.blue),
                                ],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(startlat, startlng),
                                    width: 2000,
                                    height: 2000,
                                    builder: (context) => Icon(Icons.location_on,
                                    color: Colors.red,),
                                  ),
                                ],
                              ),
                              // PolylineLayer(
                              //   polylines: [
                              //     Polyline(
                              //       points: pointsGradient,
                              //       strokeWidth: 4,
                              //       gradientColors: [
                              //         Colors.blue
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              // PolylineLayer(
                              //   polylines: snapshot.data!,
                              //   polylineCulling: true,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }else{
                  return Center(child: CircularProgressIndicator());
                } }),
        ));
  }
}