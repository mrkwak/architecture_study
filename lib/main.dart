import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Architecture Study',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: PageRouter.initial,
      //페이지 라우터
      getPages: PageRouter.routes,
    );
  }
}
