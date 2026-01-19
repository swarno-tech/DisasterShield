import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final DashboardProvider dashboardProvider;
  final int index;
  const AlertCard({
    super.key,
    required this.dashboardProvider,
    required this.index,
  });
  String getZoneNameById(int zoneId) {
    try {
      return dashboardProvider.zones.firstWhere((z) => z.id == zoneId).name;
    } catch (e) {
      return "Unknown Zone";
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalresponse =
        dashboardProvider.alertList[index].total -
        dashboardProvider.alertList[index].no_reply;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Location + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    getZoneNameById(dashboardProvider.alertList[index].id),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              _StatusChip(text: "SENT"),
            ],
          ),

          const SizedBox(height: 8),

          /// Time
          const _InfoRow(icon: Icons.access_time, text: "37 minutes ago"),

          const SizedBox(height: 16),

          /// Alert message
          const Text(
            "URGENT: Severe flooding detected in your area. "
            "Reply SAFE if secure, HELP if assistance needed.",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          /// Response rate
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Response Rate"),
              Text(
                "${(totalresponse / dashboardProvider.alertList[index].total) * 100}%",
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (totalresponse / dashboardProvider.alertList[index].total),
              minHeight: 8,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          ),

          const SizedBox(height: 16),

          /// Response stats
          Row(
            children: [
              Expanded(
                child: _ResponseBox(
                  label: "Safe",
                  count: dashboardProvider.alertList[index].safe.toString(),
                  bgColor: Color(0xFFEFFAF2),
                  iconColor: Colors.green,
                  icon: Icons.check_circle_outline,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _ResponseBox(
                  label: "Help",
                  count: dashboardProvider.alertList[index].help.toString(),
                  bgColor: Color(0xFFFFF1F0),
                  iconColor: Colors.red,
                  icon: Icons.error_outline,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _ResponseBox(
                  label: "No Reply",
                  count: dashboardProvider.alertList[index].no_reply.toString(),
                  bgColor: Color(0xFFF5F5F5),
                  iconColor: Colors.grey,
                  icon: Icons.close_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Footer
          Row(
            children: [
              Icon(Icons.message_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                "${dashboardProvider.alertList[index].total} total messages sent",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  const _StatusChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
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

class _ResponseBox extends StatelessWidget {
  final String label;
  final String count;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  const _ResponseBox({
    required this.label,
    required this.count,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(height: 6),
          Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
