import 'package:architecture_project/model/example_model.dart';
import 'package:architecture_project/viewmodel/example_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//! stateless 로 변경 필요
class ExampleDetailPage extends StatefulWidget {
  static const routeName = "/TestDetailPage";
  const ExampleDetailPage({Key? key}) : super(key: key);

  @override
  State<ExampleDetailPage> createState() => _ExampleDetailPageState();
}

class _ExampleDetailPageState extends State<ExampleDetailPage> {
  //! model를 받는 구조로 수정
  // final String contentId = Get.parameters['id'].toString();
  final ExampleModel model = Get.arguments as ExampleModel;

  // final ExampleViewModel _exampleViewModel = Get.find<ExampleViewModel>();
  late ExampleViewModel _exampleViewModel;

  @override
  void initState() {
    _exampleViewModel = Get.find<ExampleViewModel>();

    super.initState();
  }

  void fncToggleFavorite() async {
    bool result =
        _exampleViewModel.toggleFavorite(docId: model.id.toString()) as bool;
    if (result == false) {
      Get.snackbar(
        '불러오기 실패!',
        '잠시후 다시 시도하세요!',
        backgroundColor: Colors.white,
      );
      return;
    }
    setState(() {
      model.isFavorited = !model.isFavorited;
    });
    Get.snackbar(
      '변경완료!',
      '상태가 변경되었습니다.!',
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(model.title)),
        body: Center(
          child: Column(
            children: [
              Text(model.title),
              Text(model.content),
              IconButton(
                onPressed: () {
                  //! 실패시 어떻게 할지 추가
                  // fncToggleFavorite();
                  fncToggleFavorite;
                },
                icon: model.isFavorited
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
