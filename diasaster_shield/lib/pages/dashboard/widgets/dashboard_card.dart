import 'package:diasaster_shield/pages/dashboard/widgets/dashboard_stat_card.dart';
import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  final DashboardProvider dashboardProvider;
  const DashboardCards({super.key, required this.dashboardProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DashboardStatCard(
            title: "High Risk Zones",
            value: dashboardProvider.getNumberOfHighZones(),
            total: dashboardProvider.zones.length,
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
            value: dashboardProvider.cntDispathced,
            total: dashboardProvider.resources.length,
            icon: Icons.warning_amber_rounded,
            iconBgColor: Colors.yellow.shade100,
            iconColor: Colors.yellow,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DashboardStatCard(
            title: "Available Resources",
            value: dashboardProvider.calCulateAvailableResources(),
            total: dashboardProvider.resources.length,
            icon: Icons.local_shipping_rounded,
            iconBgColor: Colors.green.shade100,
            iconColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
