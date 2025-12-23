import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class IndiaRiskMap extends StatelessWidget {
  const IndiaRiskMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600, // 🔒 fixed height
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(20.5937, 78.9629), // 🇮🇳 India center
            initialZoom: 5,
            minZoom: 4,
            maxZoom: 14,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all, // pan + zoom + pinch
            ),
          ),
          children: [
            /// 🌍 Base Map
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.disaster_app',
            ),

            /// 📍 Markers
            MarkerLayer(
              markers: [
                riskMarker(
                  LatLng(19.1195, 72.8468),
                  "Andheri East",
                  "CRITICAL",
                  Colors.red,
                ),
                // riskMarker(
                //   LatLng(19.0760, 72.8777),
                //   "Bandra West",
                //   "HIGH",
                //   Colors.orange,
                // ),
                // riskMarker(
                //   LatLng(19.1490, 72.8258),
                //   "Juhu",
                //   "LOW",
                //   Colors.green,
                // ),
                // riskMarker(
                //   LatLng(19.2183, 72.9781),
                //   "Powai",
                //   "MEDIUM",
                //   Colors.amber,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Marker riskMarker(LatLng point, String area, String level, Color color) {
  return Marker(
    point: point,
    width: 150,
    height: 50,
    child: GestureDetector(
      onTap: () {
        debugPrint("Tapped on $area");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                "$area  $level",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
