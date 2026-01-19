import 'package:flutter/material.dart';

enum ResourceStatus { available, dispatched }

class ResourceCard extends StatelessWidget {
  final String name;
  final String type;
  final String coordinates;
  final String eta;
  final ResourceStatus status;

  const ResourceCard({
    super.key,
    required this.name,
    required this.type,
    required this.coordinates,
    required this.eta,
    required this.status,
  });

  bool get isDispatched => status == ResourceStatus.dispatched;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
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
                children: [
                  _IconBox(icon: _getIcon()),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _StatusChip(isDispatched: isDispatched),
            ],
          ),

          const SizedBox(height: 14),

          /// Location
          _InfoRow(icon: Icons.location_on_outlined, text: coordinates),

          const SizedBox(height: 12),

          /// ETA bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "ETA: $eta",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case "AMBULANCE":
        return Icons.local_hospital_outlined;
      case "RESCUE TEAM":
        return Icons.group_outlined;
      default:
        return Icons.local_shipping_outlined;
    }
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.blue),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isDispatched;
  const _StatusChip({required this.isDispatched});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDispatched ? Colors.green.shade300 : Colors.red.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isDispatched ? "Dispatched" : "Available",
        style: const TextStyle(fontSize: 12),
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
