import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class IndiaRiskMap extends StatelessWidget {
  const IndiaRiskMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (_, dashProvider, __) {
        return SizedBox(
          height: 900, // 🔒 fixed height
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
                  markers: dashProvider.zones.map((zone) {
                    return riskMarker(
                      LatLng(zone.latitude, zone.longitude),
                      zone.name,
                      zone.riskLevel,
                      zone.riskLevel == "CRITICAL"
                          ? Colors.red
                          : zone.riskLevel == "HIGH"
                          ? Colors.deepOrange
                          : Colors.orange,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Marker riskMarker(LatLng point, String area, String level, Color color) {
  return Marker(
    point: point,
    width: 130,
    height: 50,
    child: GestureDetector(
      behavior: HitTestBehavior.deferToChild,
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
