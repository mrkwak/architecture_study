import 'package:architecture_project/page/widget/text_feild_with_title_widget.dart';
import 'package:architecture_project/viewmodel/example_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExampleWritePage extends StatelessWidget {
  static const routeName = "/WritePage";
  final _formKey = GlobalKey<FormState>();
  final textFieldController = TextEditingController();
  final Map<String, String> writeData = {};

  final _exampleViewModel = Get.find<ExampleViewModel>();
  // late final ExampleViewModel _exampleViewModel;

  void fncSetNoteBDoc() {
    if (writeData.isNotEmpty) {
      _formKey.currentState!.save();
      bool result = _exampleViewModel.setNoteBDoc(
          title: writeData['title'].toString(),
          content: writeData['content'].toString()) as bool;

      //! 서버통신 에러일때
      if (result == false) {
        Get.snackbar(
          '저장실패!',
          '잠시후 다시 시도하세요!',
          backgroundColor: Colors.white,
        );
        return;
      }
      Get.back();
      Get.snackbar(
        '저장완료!',
        '글쓰기가 완료되었습니다!',
        backgroundColor: Colors.white,
      );
      return;
    } else {
      Get.snackbar(
        '저장실패!',
        '내용을 입력해주세요!',
        backgroundColor: Colors.white,
      );
      return;
    }
  }

  ExampleWritePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('글쓰기'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFeildWithTitleWidget(
                title: '제목',
                textFieldController: textFieldController,
                label: '',
                onSaved: (_value) {
                  writeData['title'] = _value.toString();
                },
                validator: (value) {},
              ),
              TextFeildWithTitleWidget(
                title: '내용',
                textFieldController: textFieldController,
                label: '',
                onSaved: (_value) {
                  writeData['content'] = _value.toString();
                },
                validator: (value) {},
              ),
              TextButton(
                onPressed: () async {
                  //!TODO : validate 추가 물리백키 이슈 확인
                  fncSetNoteBDoc();
                },
                child: const Text(
                  '저장하기!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
