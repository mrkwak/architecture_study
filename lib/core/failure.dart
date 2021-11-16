class Failure {
  final String code;

  Failure(this.code) {
    print(code);
  }

  //Failure는 실패에 대한 내용을 전달하기 위한 class이다. (error 처리용 DTO)
  //우리 코드에서는 error message를 전달해 dialog를 띄우는데 활용된다.
}
