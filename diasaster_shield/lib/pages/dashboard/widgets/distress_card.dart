import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DistressStatus { open, dispatched }

class DistressCard extends StatelessWidget {
  final String location;
  final String time;
  final String coordinates;
  final DistressStatus status;
  final String? dispatchedUnit;
  final int index;

  const DistressCard({
    super.key,
    required this.location,
    required this.time,
    required this.coordinates,
    required this.status,
    this.dispatchedUnit,
    required this.index
  });

  bool get isOpen => status == DistressStatus.open;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (_, dashprovider, __) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isOpen ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                  _StatusChip(status: status),
                ],
              ),

              const SizedBox(height: 6),

              /// Location
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// Time
              _InfoRow(icon: Icons.access_time, text: time),

              const SizedBox(height: 12),

              /// Coordinates
              _InfoRow(icon: Icons.location_on_outlined, text: coordinates),

              if (isOpen) ...[
                const SizedBox(height: 14),

                /// Dispatch button
                SizedBox(
                  width: double.infinity,
                  child: status == DistressStatus.dispatched
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "Dispatched",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            dashprovider.dispatched(dashprovider.resources[index]);
                          },
                          icon: const Icon(Icons.local_shipping_outlined),
                          label: const Text("Dispatch"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF151625),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                ),
              ],

              if (!isOpen && dispatchedUnit != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_hospital, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        dispatchedUnit!,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final DistressStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isOpen = status == DistressStatus.open;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOpen ? Colors.red.shade300 : Colors.green.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOpen ? "OPEN" : "DISPATCHED",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
