import 'package:diasaster_shield/pages/dashboard/widgets/zone_card.dart';
import 'package:flutter/material.dart';

class ZonesSection extends StatelessWidget {
  const ZonesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Text(
            "Zones (5)",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Monitoring geographical risk zones",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),

          /// Zone cards
          const ZoneCard(
            title: "Andheri East",
            people: "45,000 people",
            updatedAt: "Updated 30 minutes ago",
            severity: ZoneSeverity.critical,
            alertStatus: "Alert: SENT",
          ),
          const SizedBox(height: 16),
          const ZoneCard(
            title: "Bandra West",
            people: "38,000 people",
            updatedAt: "Updated about 1 hour ago",
            severity: ZoneSeverity.high,
            alertStatus: "Alert: RESPONDED",
          ),
        ],
      ),
    );
  }
}
