import 'package:diasaster_shield/models/alert_model.dart';
import 'package:diasaster_shield/models/resource_model.dart';
import 'package:diasaster_shield/models/zone_model.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/alert_section.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/distress_section.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/resource_section.dart';
import 'package:diasaster_shield/pages/dashboard/widgets/zone_section.dart';
import 'package:diasaster_shield/services/api_layer.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  //for navigation type
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

  // end
  bool isLoading = false;
  //zone provider
  List<ZoneModel> _zones = [];

  List<ZoneModel> get zones => _zones;

  void getZones() async {
    isLoading = true;
    notifyListeners();
    try {
      final _data = await ApiLayer.getZonesData();

      _zones = _data.map((mp) {
        return ZoneModel.fromJson(mp);
      }).toList();
    } catch (e) {
      throw e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  int getNumberOfHighZones() {
    int cnt = 0;
    for (var zp in zones) {
      if (zp.riskLevel == "HIGH") {
        cnt++;
      }
    }
    return cnt;
  }

  //resource provider
  List<ResourceModel> _resources = [];

  List<ResourceModel> get resources => _resources;

  void getResources() async {
    isLoading = true;
    notifyListeners();
    try {
      final _data = await ApiLayer.getResourseData();

      _resources = _data.map((mp) {
        return ResourceModel.fromJson(mp);
      }).toList();
    } catch (e) {
      throw e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  int cntDispathced = 0;

  void dispatched(ResourceModel resource) {
    resource.isAvailble = false;
    ++cntDispathced;
    notifyListeners();
  }

  int calCulateAvailableResources() {
    return _resources.length - cntDispathced;
  }

  //alert provider
    List<AlertModel> _alertList = [];

  List<AlertModel> get alertList => _alertList;
  
  void getAlerts() async {
    isLoading = true;
    notifyListeners();
    try {
      final _data = await ApiLayer.getAlertsData();

      _alertList = _data.map((mp) {
        return AlertModel.fromJson(mp);
      }).toList();
    } catch (e) {
      throw e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

}
