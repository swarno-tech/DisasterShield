import 'package:diasaster_shield/models/resource_model.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/resource_card.dart';
import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResourceSection extends StatelessWidget {
  const ResourceSection({super.key});

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
                "Resources (${dashprovider.resources.length})",
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
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: dashprovider.resources.length,
                itemBuilder: (context, index) {
                  return ResourceCard(
                    name: "Ambulance Unit A${index + 1}",
                    type: "AMBULANCE",
                    coordinates:
                        "${dashprovider.resources[index].lat}, ${dashprovider.resources[index].lon}",
                    eta: "8 minutes",
                    status: dashprovider.resources[index].isAvailble
                        ? ResourceStatus.available
                        : ResourceStatus.dispatched,
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
