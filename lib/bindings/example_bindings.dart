import 'package:architecture_project/repository/example_repository.dart';
import 'package:architecture_project/viewmodel/example_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ExampleBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ExampleViewModel>(ExampleViewModel(
      repository: ExampleRepository(
        firestore: FirebaseFirestore.instance,
      ),
    ));
  }
}
