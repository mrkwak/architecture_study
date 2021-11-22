import 'package:architecture_project/core/failure.dart';
import 'package:architecture_project/core/view_state.dart';
import 'package:architecture_project/model/example_model.dart';
import 'package:architecture_project/repository/example_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExampleViewModel extends GetxController {
  late final ExampleRepository _repository;
  ExampleViewModel({required repository}) {
    _repository = repository;
  }

  //! 화면의 상태를 관리하기 위함.
  final Rxn<ViewState> _viewState = Rxn(Initial());
  ViewState? get viewState => _viewState.value;

  //!화면에서 보관할 데이터(상태)
  RxList<ExampleModel> exampleList = <ExampleModel>[].obs;

  List<ExampleModel> get favoritedExmapleList {
    return exampleList.where((element) => element.isFavorited == true).toList();
  }

  Future<void> getExampleList() async {
    //서버 통신 시작 => Loading으로 화면 바꾸기
    _viewState.value = Loading();

    Either<Failure, List<ExampleModel>> either =
        await _repository.getAllExampleModel();

    //fold를 사용하면 right, left 결과에 따라 다른 내용이 호출
    // 아래는 left(실패)일 경우 left결과값 그대로 반환
    //  right(성공)일 경우 right 결과값 그대로 반환
    var result = either.fold(
        (Failure left) => left, (List<ExampleModel> right) => right);

    if (either.isLeft()) {
      //isLeft가 true이면 실패한 상태
      //즉, result에는 left(Failure)가 들어가 있음
      // 그걸 담은 Error (ViewState를 상속받은)에 넣어서 셋팅
      _viewState.value = Error(result as Failure);
      //화면 error로 바꾸고 종료
      return;
    }

    //혹시 모르니, 기존 데이터 지우고 새로운 데이터 입력
    exampleList.clear();
    exampleList.addAll(result as List<ExampleModel>);
    //성공인 경우는 Loaded로 바꿔서 화면이 화면 제대로 그리도록 알려줌.
    _viewState.value = Loaded();
  }

  Future<void> getExampleListByIsFavorited() async {
    //서버 통신 시작 => Loading으로 화면 바꾸기
    _viewState.value = Loading();

    Either<Failure, List<ExampleModel>> either =
        await _repository.getExampleModelByIsFavorited();

    //fold를 사용하면 right, left 결과에 따라 다른 내용이 호출
    // 아래는 left(실패)일 경우 left결과값 그대로 반환
    //  right(성공)일 경우 right 결과값 그대로 반환
    var result = either.fold(
        (Failure left) => left, (List<ExampleModel> right) => right);

    if (either.isLeft()) {
      //isLeft가 true이면 실패한 상태
      //즉, result에는 left(Failure)가 들어가 있음
      // 그걸 담은 Error (ViewState를 상속받은)에 넣어서 셋팅
      _viewState.value = Error(result as Failure);
      //화면 error로 바꾸고 종료
      return;
    }

    //혹시 모르니, 기존 데이터 지우고 새로운 데이터 입력
    exampleList.clear();
    exampleList.addAll(result as List<ExampleModel>);
    //성공인 경우는 Loaded로 바꿔서 화면이 화면 제대로 그리도록 알려줌.
    _viewState.value = Loaded();
  }

  //2개의 화면에서 호출 가능
  Future<void> toggleFavorite({required String docId}) async {
    //1. 변경 할 모델 찾기
    ExampleModel model =
        exampleList.firstWhere((element) => element.id == docId);

    //2. 서버에 요청 하기
    model.isFavorited = !model.isFavorited;

    Either<Failure, void> either =
        await _repository.toggleFavorite(updatedModel: model);

    if (either.isLeft()) {
      //!ERROR
      model.isFavorited = !model.isFavorited;
      return;
    }
    //3. 해당 모델 찾아서 바꿔주기

    //3. 화면에 반영하기
    exampleList.refresh();
  }

  Future<void> setNoteBDoc(
      {required String title, required String content}) async {
    //1. 변경 할 모델 찾기
    ExampleModel model = ExampleModel(
        title: title,
        isFavorited: false,
        content: content,
        createdAt: DateTime.now());
    // ExampleModel model = exampleList.first;

    //2. 서버에 요청 하기
    Either<Failure, void> either =
        await _repository.setNoteBDoc(setModel: model);

    if (either.isLeft()) {
      //!ERROR
      return;
    }
    //3. 해당 모델 찾아서 바꿔주기

    //3. 화면에 반영하기
    exampleList.refresh();
  }
}
