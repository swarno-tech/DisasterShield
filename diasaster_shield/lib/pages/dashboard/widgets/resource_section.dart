import 'package:diasaster_shield/pages/dashboard/widgets/resource_card.dart';
import 'package:flutter/material.dart';

class ResourceSection extends StatelessWidget {
  const ResourceSection({super.key});

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
            "Resources (5)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),

          /// Summary
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Available: ",
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: "3",
                  style: TextStyle(color: Colors.green),
                ),
                TextSpan(
                  text: "   Dispatched: ",
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: "2",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),

          /// Resource cards
          const ResourceCard(
            name: "Ambulance Unit A1",
            type: "AMBULANCE",
            coordinates: "19.1180, 72.8450",
            eta: "8 minutes",
            status: ResourceStatus.dispatched,
          ),
          const SizedBox(height: 16),
          const ResourceCard(
            name: "Rescue Team R2",
            type: "RESCUE TEAM",
            coordinates: "19.0610, 72.8310",
            eta: "5 minutes",
            status: ResourceStatus.dispatched,
          ),
        ],
      ),
    );
  }
}
