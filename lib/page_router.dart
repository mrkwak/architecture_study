import 'package:architecture_project/bindings/example_bindings.dart';
import 'package:architecture_project/page/example_detail_page.dart';
import 'package:architecture_project/page/example_write_page.dart';
import 'package:get/get.dart';

import 'page/example_page.dart';

class PageRouter {
  //TODO : 자신이 개발할 페이지로 initial 네임 수정해서 개발
  static const initial = ExamplePage.routeName;

  static final routes = [
    //TODO: 자신의 페이지 추가 , GetXController 바인딩 필수
    GetPage(
      name: ExamplePage.routeName,
      page: () => const ExamplePage(),
      binding: ExampleBindings(),
    ),
    GetPage(
      name: ExampleDetailPage.routeName,
      page: () => ExampleDetailPage(),
      binding: ExampleBindings(),
    ),
    GetPage(
      name: ExampleWritePage.routeName,
      page: () => ExampleWritePage(),
      binding: ExampleBindings(),
    ),
  ];
}
