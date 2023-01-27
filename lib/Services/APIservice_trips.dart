import 'package:biker_app/Services/GetTrips.dart';
import 'package:dio/dio.dart';

class APIservice_trip{
  final Dio _dio = Dio();
  final String Url = "https://bikebuds-backend-production.up.railway.app/api/trips";
  Future<List<GetTrips>> getTrips() async {
    try {
      final response = await _dio.get(Url);
      var trips = response.data as List;
      List<GetTrips> trip = trips.map((e) => GetTrips.fromJson(e)).toList();
      return trip;
    } catch (e){
      return Future.error(e);
    }
  }
}
Future createTrip(String name  , String phoneNumber) async {
  final Dio _dio = Dio();
  try {
    final url = 'https://bikebuds-backend-production.up.railway.app/api/trips';
    var jsonBody = {
      "name" : name, "phoneNumber": phoneNumber
    };
    final respose = await _dio.post(url, data: jsonBody);
    if(respose.statusCode == 201){
      print(respose.data);
    }else{
      print(respose.statusMessage);
    }
  }catch (e){
    print(e);
    return Future.error(e);
  }
}