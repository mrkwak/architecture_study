import 'package:architecture_project/model/example_model.dart';
import 'package:architecture_project/page/example_page.dart';
import 'package:architecture_project/viewmodel/example_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExampleWritePage extends StatelessWidget {
  static const routeName = "/WritePage";
  final _formKey = GlobalKey<FormState>();
  final textFieldController = TextEditingController();
  final Map<String, String> writeData = {};

  late ExampleViewModel _exampleViewModel;

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
                  // if(formKey.currentState!.validate()){
                  // validation 이 성공하면 true 가 리턴돼요!
                  //! 함수화
                  _formKey.currentState!.save();
                  if (writeData.isNotEmpty) {
                    //! model에 새로운거 어떻게 추가하는지???

                    _exampleViewModel.setNoteBDoc(
                        title: writeData['title'].toString(),
                        content: writeData['content'].toString());
                    // AddNoteB().addNoteBDoc(writeData: writeData);
                    Get.back();

                    Get.snackbar(
                      '저장완료!',
                      '폼 저장이 완료되었습니다!',
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

                  // }
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

class TextFeildWithTitleWidget extends StatelessWidget {
  final String title;
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  final TextEditingController textFieldController;
  const TextFeildWithTitleWidget({
    Key? key,
    required this.title,
    required this.textFieldController,
    required this.label,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(title),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          // controller: textFieldController,
        )
      ],
    );
  }
}
