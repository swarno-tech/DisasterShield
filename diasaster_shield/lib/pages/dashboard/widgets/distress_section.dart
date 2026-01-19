

import 'package:diasaster_shield/pages/dashboard/widgets/distress_card.dart';
import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistressSection extends StatelessWidget {
  const DistressSection({super.key});

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
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: dashprovider.resources.length,
                itemBuilder: (context, index) {
                  return DistressCard(
                    location: dashprovider.resources[index].name,
                    time: "30 minutes ago",
                    coordinates:
                        "${dashprovider.resources[index].lat}, ${dashprovider.resources[index].lon}",
                    status: dashprovider.resources[index].isAvailble
                        ? DistressStatus.open
                        : DistressStatus.dispatched,
                    index: index,
                  );
                },
              ),

              // const SizedBox(height: 16),
              // const DistressCard(
              //   location: "Andheri East",
              //   time: "35 minutes ago",
              //   coordinates: "19.1201, 72.8470",
              //   status: DistressStatus.dispatched,
              //   dispatchedUnit: "Ambulance Unit A1",
              // ),
            ],
          ),
        );
      },
    );
  }
}
