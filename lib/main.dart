import 'package:biker_app/maps_services/getroute_Data.dart';
import 'package:biker_app/maps_services/select_destination.dart';
import 'package:biker_app/maps_services/select_start.dart';
import 'package:biker_app/maps_services/show_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:latlong2/latlong.dart';
double startlat = 18.5204;
double startlng = 73.8567;
double destilat = 19.0760;
double destilng = 72.8777;
late Future<List<Polyline>> polylines;
late  List<LatLng> routePoints;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('timepass'),
      ),
      body :
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: ()=>{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => select_start()),
            )
          }
              , child: Text("select current location "))
          ,
          ElevatedButton(onPressed: ()=>{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => select_destination()),
            )
          }
              , child: Text("select destination location")),
          ElevatedButton(onPressed: ()=>{
            mapp()
          }
              , child: Text("get route data")),
          ElevatedButton(onPressed: ()=>{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PolylinePage()),
            )
          }
              , child: Text("select destination location")),
        ],
      ),
    );
  }
}