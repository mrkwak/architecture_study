import 'package:architecture_project/core/view_state.dart';
import 'package:architecture_project/page/example_detail_page.dart';
import 'package:architecture_project/page/widget/tile_widget.dart';
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

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: const [
                      ListTile(
                        horizontalTitleGap: 100,
                        minLeadingWidth: 0,
                        leading: Text('순번', style: TextStyle(height: 2.5)),
                        title: Text('내용', style: TextStyle(height: 2.5)),
                      ),
                    ]),
                // SingleChildScrollView(
                // child:

                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (_, index) {
                    return TileWidget(
                      contentNo: '$index',
                      content:
                          _exampleViewModel.exampleList[index].title.toString(),
                      contentDate: _exampleViewModel
                          .exampleList[index].createdAt
                          .toString(),
                      onPressed: () => Get.toNamed(
                        ExampleDetailPage.routeName,
                        parameters: {
                          'id': _exampleViewModel.exampleList[index].id
                        },
                      ),
                    );
                  },
                  itemCount: _exampleViewModel.exampleList.length,
                  // separatorBuilder: (context, index) {
                  //   if (index == 0) return const SizedBox.shrink();
                  //   return const Divider();
                  // },
                ),

                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
