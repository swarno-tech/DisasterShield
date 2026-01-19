import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/dashboard-tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardTabs(),
        SizedBox(height: 16),
        context
            .watch<DashboardProvider>()
            .getCorrectSection(), // sections wala part ayega
      ],
    );
  }
}
