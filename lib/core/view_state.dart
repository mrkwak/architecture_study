import 'failure.dart';

abstract class ViewState {}

class Initial extends ViewState {}

class Loading extends ViewState {}

class Loaded extends ViewState {}

class Error extends ViewState {
  //Error 상태는 failure를 받아서 화면에 가져다 줌.
  Failure failure;
  Error(this.failure);
}
