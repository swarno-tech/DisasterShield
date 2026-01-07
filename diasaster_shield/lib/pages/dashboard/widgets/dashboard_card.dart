import 'package:diasaster_shield/pages/dashboard/widgets/dashboard_stat_card.dart';
import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DashboardStatCard(
            title: "High Risk Zones",
            value: 3,
            total: 5,
            icon: Icons.warning_rounded,
            iconBgColor: Colors.red.shade100,
            iconColor: Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DashboardStatCard(
            title: "Active Alerts",
            value: 2,
            total: 3,
            icon: Icons.people_alt_rounded,
            iconBgColor: Colors.orange.shade100,
            iconColor: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DashboardStatCard(
            title: "Open Distress",
            value: 1,
            total: 3,
            icon: Icons.warning_amber_rounded,
            iconBgColor: Colors.yellow.shade100,
            iconColor: Colors.yellow,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DashboardStatCard(
            title: "Available Resources",
            value: 3,
            total: 5,
            icon: Icons.local_shipping_rounded,
            iconBgColor: Colors.green.shade100,
            iconColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
