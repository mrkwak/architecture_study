import 'package:cloud_firestore/cloud_firestore.dart';

class ExampleModel {
  final int id;
  final String contents;
  final List<ExampleSubModel> subContentList;

  ExampleModel(
      {required this.id, required this.contents, required this.subContentList});

  //! fromJson이라면 서버에서 이미 처리 다한 json만 읽으면 된다. (깔끔하다.)
  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    //json 중첩 구조를 subModel로 빼기 위한 로직
    List<Map<String, dynamic>> contentJsonList =
        json['sub_content_list'] as List<Map<String, dynamic>>;

    return ExampleModel(
        id: json['id'],
        contents: json['contents'],
        subContentList:
            contentJsonList.map((e) => ExampleSubModel.fromJson(e)).toList());
  }

  //! 하지만 firebase는 컬랙션 구조에 따라 따로 추가 호출해서 넣어주어야 한다.
  factory ExampleModel.fromFirebase(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return ExampleModel(
        id: json['id'],
        contents: json['contents'],
        //! 만약 subContentList가 내부 컬랙션이였으면 ?
        //! doc.reference.collection('sub_collection').get(); =>한걸 list화 해서 넣어주어야 한다.
        subContentList: json['sub_content_list']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contents': contents,
      //! 일반적인 restapi라면 아래와 같이 해서 보내주면 된다.
      //! 하지만 firestore는 서브데이터를 따로 저장해야하기에 추가적인 로직이 필요하다.
      // 'sub_content_list': subContentList.map((e) => e.toJson()).toList(),
    };
  }
}

class ExampleSubModel {
  final int id;
  final String contents;

  ExampleSubModel({required this.id, required this.contents});

  factory ExampleSubModel.fromJson(Map<String, dynamic> json) {
    return ExampleSubModel(id: json['id'], contents: json['contents']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contents': contents,
    };
  }
}
