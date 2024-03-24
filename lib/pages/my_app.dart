import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apps/route/route_custom.dart';
import '../apps/route/route_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouterName.mainPage,
      getPages: RouterCustom.getPage,
      debugShowCheckedModeBanner: false,
    );
  }
}
