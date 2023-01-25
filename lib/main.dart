import 'package:biker_app/maps_services/getroute_Data.dart';
import 'package:biker_app/maps_services/select_destination.dart';
import 'package:biker_app/maps_services/select_start.dart';
import 'package:biker_app/maps_services/show_routes.dart';
import 'package:flutter/material.dart';
double startlat = 18.5204;
double startlng = 73.8567;
double destilat = 19.0760;
double destilng = 72.8777;
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
            mapp(startlat, startlng, destilat, destiLng)
          }
              , child: Text("get route data")),
          ElevatedButton(onPressed: ()=>{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PolylinePage(startlat:startlat, startlng: startlng, endlat: destilat, endlng: destilng)),
            )
          }
              , child: Text("select destination location")),
        ],
      ),
    );
  }
}