import 'package:architecture_project/page/example_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ExampleWritePage extends StatelessWidget {
  static const routeName = "/WritePage";
  final _formKey = GlobalKey<FormState>();
  final textFieldController = TextEditingController();
  final Map<String, String> result = {};
  final CollectionReference noteB =
      FirebaseFirestore.instance.collection('note_b');

  ExampleWritePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> addNoteB() {
      return noteB.add({
        'title': result['title'],
        'content': result['content'],
        'created_at': Timestamp.fromDate(DateTime.now()),
        'is_favorited': false,
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFeildWithTitleWidget(
                title: '제목',
                textFieldController: textFieldController,
                label: '',
                onSaved: (_value) {
                  result['title'] = _value.toString();
                },
                validator: (value) {},
              ),
              TextFeildWithTitleWidget(
                title: '내용',
                textFieldController: textFieldController,
                label: '',
                onSaved: (_value) {
                  result['content'] = _value.toString();
                },
                validator: (value) {},
              ),
              TextButton(
                onPressed: () async {
                  //!TODO : validate 추가 물리백키 이슈 확인
                  // if(formKey.currentState!.validate()){
                  // validation 이 성공하면 true 가 리턴돼요!
                  if (result.isNotEmpty) {
                    Get.offNamed(
                      ExamplePage.routeName,
                    );
                    _formKey.currentState!.save();

                    addNoteB();

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
