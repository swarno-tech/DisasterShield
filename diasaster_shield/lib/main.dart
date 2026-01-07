import 'package:diasaster_shield/pages/dashboard/dashboard.dart';
import 'package:diasaster_shield/pages/dashboard/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=> DashboardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Disaster-Shield',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: MyDashboard(),
      ),
    );
  }
}
