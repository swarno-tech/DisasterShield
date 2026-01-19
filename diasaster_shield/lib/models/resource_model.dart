class ResourceModel {
  final double lat;
  final double lon;
  final String name;
  bool isAvailble;

  ResourceModel({
    required this.lat,
    required this.lon,
    required this.isAvailble,
    required this.name
  });

  factory ResourceModel.fromJson(Map<String, dynamic> mp) {
    return ResourceModel(
      lat: mp["latitude"],
      lon: mp["longitude"],
      isAvailble: mp["available"],
      name: mp["name"]
    );
  }
}
