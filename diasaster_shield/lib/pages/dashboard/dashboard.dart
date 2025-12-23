import 'package:diasaster_shield/pages/dashboard/widgets/dashboard_card.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/india_map.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/main_content.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/myappbar.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyAppBar(),
                const SizedBox(height: 15),
                DashboardCards(),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: MainContent()),
                      SizedBox(width: 15),
                      Expanded(child: IndiaRiskMap()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
