import 'package:flutter/material.dart';

enum ZoneSeverity { critical, high }

class ZoneCard extends StatelessWidget {
  final String title;
  final String people;
  final String updatedAt;
  final ZoneSeverity severity;
  final String alertStatus;

  const ZoneCard({
    super.key,
    required this.title,
    required this.people,
    required this.updatedAt,
    required this.severity,
    required this.alertStatus,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCritical = severity == ZoneSeverity.critical;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              _SeverityChip(isCritical: isCritical),
            ],
          ),

          const SizedBox(height: 12),

          /// People
          _InfoRow(icon: Icons.people_outline, text: people),
          const SizedBox(height: 6),

          /// Updated time
          _InfoRow(icon: Icons.access_time, text: updatedAt),

          const SizedBox(height: 12),

          /// Alert badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(alertStatus, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _SeverityChip extends StatelessWidget {
  final bool isCritical;

  const _SeverityChip({required this.isCritical});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isCritical ? Colors.red : Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isCritical ? "CRITICAL" : "HIGH",
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
