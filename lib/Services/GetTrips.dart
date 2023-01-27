class GetTrips {
  GetTrips({
    String? id,
    String? name,
    String? phoneNumber,
    List<Location>? location,
  }) {
    _id = id;
    _name = name;
    _location = location;
  }

  GetTrips.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    if (json['location'] != null) {
      _location = [];
      json['location'].forEach((v) {
        _location?.add(Location.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _phoneNumber;
  List<Location>? _location;
  GetTrips copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    List<Location>? location,
  }) =>
      GetTrips(
        id: id ?? _id,
        name: name ?? _name,
        phoneNumber: phoneNumber ?? _phoneNumber,
        location: location ?? _location,
      );
  String? get id => _id;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  List<Location>? get location => _location;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    if (_location != null) {
      map['location'] = _location?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Location {
  Location({
    num? longitude,
    num? latitude,
  }) {
    _longitude = longitude;
    _latitude = latitude;
  }
  Location.fromJson(dynamic json) {
    _longitude = json['longitude'];
    _latitude = json['latitude'];
  }
  num? _longitude;
  num? _latitude;
  Location copyWith({
    num? longitude,
    num? latitude,
  }) =>
      Location(
        longitude: longitude ?? _longitude,
        latitude: latitude ?? _latitude,
      );
  num? get longitude => _longitude;
  num? get latitude => _latitude;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    return map;
  }
}

