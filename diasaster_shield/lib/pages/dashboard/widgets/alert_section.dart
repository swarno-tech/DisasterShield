import 'package:diasaster_shield/pages/dashboard/widgets/alert_card.dart';
import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertsSection extends StatelessWidget {
  const AlertsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (_, dashprovider, __) {
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
                "Active Alerts (${dashprovider.alertList.length})",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "SMS-based citizen interaction",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),

              /// Alert card
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: dashprovider.alertList.length,
                itemBuilder: (context, index) {
                  return AlertCard(dashboardProvider: dashprovider,index: index,);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
