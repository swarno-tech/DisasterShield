import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({super.key});

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
          /// Location + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Andheri East",
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
            children: const [Text("Response Rate"), Text("21.4%")],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.214,
              minHeight: 8,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          ),

          const SizedBox(height: 16),

          /// Response stats
          Row(
            children: const [
              Expanded(
                child: _ResponseBox(
                  label: "Safe",
                  count: "342",
                  bgColor: Color(0xFFEFFAF2),
                  iconColor: Colors.green,
                  icon: Icons.check_circle_outline,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _ResponseBox(
                  label: "Help",
                  count: "87",
                  bgColor: Color(0xFFFFF1F0),
                  iconColor: Colors.red,
                  icon: Icons.error_outline,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _ResponseBox(
                  label: "No Reply",
                  count: "1571",
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
            children: const [
              Icon(Icons.message_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                "2,000 total messages sent",
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
