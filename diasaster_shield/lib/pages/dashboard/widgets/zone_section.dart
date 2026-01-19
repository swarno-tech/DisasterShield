import 'package:diasaster_shield/pages/dashboard/widgets/zone_card.dart';
import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZonesSection extends StatelessWidget {
  const ZonesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (_, dashProvider, __) {
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
                "Zones (${dashProvider.zones.length})",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Monitoring geographical risk zones",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),

              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: dashProvider.zones.length,
                itemBuilder: (context, index) {
                  return ZoneCard(
                    title: dashProvider.zones[index].name,
                    people: "45,000 people",
                    updatedAt: "Updated 30 minutes ago",
                    severity: dashProvider.zones[index].riskLevel == "CRITICAL"
                        ? ZoneSeverity.critical
                        : dashProvider.zones[index].riskLevel == "HIGH"
                        ? ZoneSeverity.high
                        : ZoneSeverity.low,
                    alertStatus: "Alert: SENT",
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
