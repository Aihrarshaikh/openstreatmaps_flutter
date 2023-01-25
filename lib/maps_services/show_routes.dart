import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
late Future<List<Polyline>> polylines;
class PolylinePage extends StatefulWidget {
  static const String route = 'polyline';
  double startlat;
  double startlng;
  double endlat;
  double endlng;
  PolylinePage({Key? key, required this.startlat,required this.startlng,required this.endlat,required this.endlng}) : super(key: key);
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
          latitude: widget.startlat, longitude: widget.startlng),
      endCoordinate: ORSCoordinate(
          latitude: widget.endlat, longitude: widget.endlng),
    );
    List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();
    final polyLines = [
      Polyline(
        points: [LatLng(13, 77.5),
          LatLng(13.02, 77.51),
          LatLng(13.05, 77.53),
          LatLng(13.155, 77.54),
          LatLng(13.159, 77.55),
          LatLng(13.17, 77.55),
        ],
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
    final points = [LatLng(13, 77.5),
      LatLng(13.02, 77.51),
      LatLng(13.05, 77.53),
      LatLng(13.155, 77.54),
      LatLng(13.159, 77.55),
      LatLng(13.17, 77.55),
    ];

    final pointsGradient = [LatLng(13, 77.5),
      LatLng(13.02, 77.51),
      LatLng(13.05, 77.53),
      LatLng(13.155, 77.54),
      LatLng(13.159, 77.55),
      LatLng(13.17, 77.55),
    ];

    return Scaffold(
      // appBar: AppBar(title: const Text('Polylines')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<Polyline>>(
            future: polylines,
            builder:
                (BuildContext context, AsyncSnapshot<List<Polyline>> snapshot) {
              debugPrint('snapshot: ${snapshot.hasData}');
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
                          center: LatLng(13, 77.5),
                          zoom: 14,
                          onTap: (tapPosition, point) {
                            setState(() {
                              debugPrint('onTap');
                              polylines = getPolylines();
                            });
                          },
                        ),
                        children: [
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(13, 77.5),
                                width: 30,
                                height: 30,
                                builder: (context) =>
                                    Icon(Icons.import_contacts_sharp),
                              ),
                              Marker(
                                point: LatLng(13.17, 77.55),
                                width: 30,
                                height: 30,
                                builder: (context) => FlutterLogo(size: 10,),
                              ),
                            ],
                          ),
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
                                  color: Colors.purple),
                            ],
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: pointsGradient,
                                strokeWidth: 4,
                                gradientColors: [
                                  const Color(0xffE40203),
                                  const Color(0xffFEED00),
                                  const Color(0xff007E2D),
                                ],
                              ),
                            ],
                          ),
                          PolylineLayer(
                            polylines: snapshot.data!,
                            polylineCulling: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Text(
                  'Getting map data...\n\nTap on map when complete to refresh map data.');
            },
          ),
        ));
  }
}