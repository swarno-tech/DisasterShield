import 'package:diasaster_shield/pages/dashboard/widgets/alert_card.dart';
import 'package:flutter/material.dart';

class AlertsSection extends StatelessWidget {
  const AlertsSection({super.key});

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
          const Text(
            "Active Alerts (3)",
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
          const AlertCard(),
        ],
      ),
    );
  }
}
