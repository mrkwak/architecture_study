import 'package:architecture_project/viewmodel/example_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExampleDetailPage extends StatelessWidget {
  static const routeName = "/TestDetailPage";
  ExampleDetailPage({Key? key}) : super(key: key);
  final String contentId = Get.parameters['id'].toString();
  final ExampleViewModel _exampleViewModel = Get.find<ExampleViewModel>();

  @override
  Widget build(BuildContext context) {
    String title = _exampleViewModel.exampleList
        .firstWhere((element) => element.id == contentId)
        .title;
    String content = _exampleViewModel.exampleList
        .firstWhere((element) => element.id == contentId)
        .content;
    bool isFavorited = _exampleViewModel.exampleList
        .firstWhere((element) => element.id == contentId)
        .isFavorited;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            children: [
              Text(title),
              Text(content),
              if (isFavorited)
                const SizedBox(
                  child: Icon(Icons.favorite),
                )
              else
                const SizedBox(
                  child: Icon(Icons.favorite_border),
                )
            ],
          ),
        ),
      ),
    );
  }
}

// class ExampleDetailPage extends StatefulWidget {
//   static const routeName = "/TestDetailPage";

//   const ExampleDetailPage({Key? key}) : super(key: key);
//   String contentId = Get.parameters['id'].toString(
//   @override
//   // _ExampleDetailPageState createState() => _ExampleDetailPageState();

//   State<ExampleDetailPage> createState() => _ExampleDetailPageState();
// }

// class _ExampleDetailPageState extends State<ExampleDetailPage> {
//   String contentId = Get.parameters['id'].toString();
//   late ExampleViewModel _exampleViewModel;

//   @override
//   void initState() {
//     _exampleViewModel = Get.find<ExampleViewModel>();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Detail Page'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded),
//             onPressed: () => Get.off(const ExamplePage()),
//           ),
//         ),
//         body: Center(
//           child: Obx(() {
//             ViewState state = _exampleViewModel.viewState!;

//             print(state);
//             if (state is Initial) {
//               return TextButton(
//                   onPressed: () {
//                     _exampleViewModel.getExampleListbyId(contentId);
//                   },
//                   child: const Text("데이터 가져오기"));
//               // return const Text('test0');
//             }
//             if (state is Loading) {
//               return const CircularProgressIndicator();
//             }
//             if (state is Error) {
//               return TextButton(
//                   onPressed: () {
//                     _exampleViewModel.getExampleListbyId(contentId);
//                   },
//                   child: const Text("Error Retry!"));
//             }

//             print(_exampleViewModel.exampleList[0].toJson().toString());
//             return
//                 // GetBuilder<ExampleViewModel>(
//                 //   builder: (_) {
//                 //     return Text(_exampleViewModel.exampleList[0].toJson().toString());
//                 //   },
//                 // );
//                 Text(_exampleViewModel.exampleList
//                     .firstWhere((element) => element.id == contentId)
//                     .toJson()
//                     .toString());
//           }),
//         ));
//   }
// }
