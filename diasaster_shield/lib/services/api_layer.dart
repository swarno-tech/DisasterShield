import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiLayer {
  static Future<List<Map<String, dynamic>>> getZonesData() async {
    final url = Uri.parse(
      "https://disastershield-hdli.onrender.com/api/zones/",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(decoded);
    } else {
      throw Exception("Server error: ${response.body}");
    }
  }

  static Future<List<Map<String, dynamic>>> getResourseData() async {
    final url = Uri.parse(
      "https://disastershield-hdli.onrender.com/api/resources",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(decoded);
    } else {
      throw Exception("Server error: ${response.body}");
    }
  }

  static Future<List<Map<String, dynamic>>> getAlertsData() async {
    final url = Uri.parse(
      "https://disastershield-hdli.onrender.com/api/alert/1/stats",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      return [decoded];
    } else {
      throw Exception("Server error: ${response.body}");
    }
  }

  //   static Future<void> updateResourceAvailability(int id, bool available) async {
  //   final url = Uri.parse(
  //     "https://romona-coarsest-albert.ngrok-free.dev/api/resources/$id/",
  //   );

  //   final response = await http.patch(
  //     url,
  //     headers: {
  //       "ngrok-skip-browser-warning": "true",
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode({
  //       "available": available,
  //     }),
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 204) {
  //     print("Availability updated successfully");
  //   } else {
  //     throw Exception("Failed to update: ${response.body}");
  //   }
  // }
}
