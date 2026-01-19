class ZoneModel {
  final double latitude;
  final double longitude;
  final String name;
  final String riskLevel;
  final int id;

  ZoneModel({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.riskLevel,
    required this.id
  });
  factory ZoneModel.fromJson(Map<String, dynamic> mp) {
    return ZoneModel(
      latitude: mp["latitude"],
      longitude: mp["longitude"],
      name: mp["name"],
      riskLevel: mp["risk_level"],
      id: mp["id"]
    );
  }
}
