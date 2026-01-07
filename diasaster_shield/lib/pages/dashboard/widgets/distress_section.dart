import 'package:diasaster_shield/pages/dashboard/widgets/distress_card.dart';
import 'package:flutter/material.dart';

class DistressSection extends StatelessWidget {
  const DistressSection({super.key});

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
            "Distress Requests (3)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Real-time incident tracking",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),

          /// Cards
          const DistressCard(
            location: "Andheri East",
            time: "30 minutes ago",
            coordinates: "19.1195, 72.8468",
            status: DistressStatus.open,
          ),
          const SizedBox(height: 16),
          const DistressCard(
            location: "Andheri East",
            time: "35 minutes ago",
            coordinates: "19.1201, 72.8470",
            status: DistressStatus.dispatched,
            dispatchedUnit: "Ambulance Unit A1",
          ),
        ],
      ),
    );
  }
}
