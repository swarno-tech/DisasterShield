import 'package:diasaster_shield/pages/dashboard/widgets/alert_section.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/distress_section.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/resource_section.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/zone_section.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int index = 0;
  final List<Widget> dashboardSections = [
    ZonesSection(),
    AlertsSection(),
    DistressSection(),
    ResourceSection(),
  ];
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  Widget getCorrectSection() {
    return dashboardSections[index];
  }
}
