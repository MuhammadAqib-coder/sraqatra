class DonorsModel {
  late final String name, bloodGroup, location, gender, phone;
  late final double lat, lng;
  double? distance;

  DonorsModel(
      {required this.name,
      required this.bloodGroup,
      required this.location,
      required this.gender,
      required this.phone,
      required this.lat,
      required this.lng,
      this.distance});

   set setDistance(value) {
    distance = value;
  }

  DonorsModel.fromJson(map) {
    name=
    map['name'];
    phone=
    map['phone'];
    bloodGroup=
    map['blood_group'];
    gender=
    map['gender'];
    location=
    map['location'];
    lat=
    map['latitude'];
    lng=
    map['longitude'];
  }
}
