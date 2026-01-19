import 'package:diasaster_shield/pages/dashboard/widgets/dashboard_card.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/india_map.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/main_content.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/myappbar.dart';
import 'package:diasaster_shield/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DashboardProvider>().getZones();
      context.read<DashboardProvider>().getResources();
      context.read<DashboardProvider>().getAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardProvider>(
        builder: (_, dashprovider, __) {
          print(dashprovider.zones);
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyAppBar(),
                    const SizedBox(height: 15),
                    DashboardCards(dashboardProvider: dashprovider),
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
          );
        },
      ),
    );
  }
}
