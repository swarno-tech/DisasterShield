class AlertModel {
  final int total;
  final int safe;
  final int no_reply;
  final int help;
  final int id;

  AlertModel({
    required this.total,
    required this.help,
    required this.no_reply,
    required this.safe,
    required this.id
  });

  factory AlertModel.fromJson(Map<String, dynamic> mp) {
    return AlertModel(
      total: mp["total"],
      help: mp["safe"],
      no_reply: mp["no_reply"],
      safe: mp["help"],
      id: mp["zone_id"]
    );
  }
}
