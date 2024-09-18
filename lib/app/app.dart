import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movie_db/app/ui/views/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeView(),
    );
  }
}
