import 'package:architecture_project/core/view_state.dart';
import 'package:architecture_project/viewmodel/example_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamplePage extends StatefulWidget {
  static const routeName = "/TestPage";
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late ExampleViewModel _exampleViewModel;

  @override
  void initState() {
    _exampleViewModel = Get.find<ExampleViewModel>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          //viewmodel의 viewstate가져오기 => !붙인 이유는 nullable을 non-nullable로 풀어주려고

          //화면 상태에 따라 화면 그려주기.
          ViewState state = _exampleViewModel.viewState!;

          if (state is Initial) {
            return TextButton(
                onPressed: () {
                  _exampleViewModel.getExampleList();
                },
                child: const Text("데이터 가져오기"));
          }

          if (state is Error) {
            return TextButton(
                onPressed: () {
                  _exampleViewModel.getExampleList();
                },
                child: const Text("Error Retry!"));
          }

          if (state is Loading) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                    _exampleViewModel.exampleList[index].toJson().toString()),
              );
            },
            itemCount: _exampleViewModel.exampleList.length,
          );
        }),
      ),
    );
  }
}
