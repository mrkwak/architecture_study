import 'package:architecture_project/core/failure.dart';
import 'package:architecture_project/model/example_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ExampleRepository {
  //외부에서는 접근하지 못하게 하기 위해 private
  late final FirebaseFirestore _firestore;

  ExampleRepository({required firestore}) {
    _firestore = firestore;
  }

  Future<Either<Failure, ExampleModel>> getExampleModelById(
      {required String id}) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('note_b').doc(id).get();

      //! Model에서 만든 factory함수 활용
      ExampleModel result = ExampleModel.fromFirebase(snapshot);

      //! 성공 케이스
      return Right(result);
    } catch (e) {
      //! Left는 실패한 케이스 결과값이다.
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<ExampleModel>>> getAllExampleModel() async {
    try {
      //! 여러개 데이터 가져온 경우
      QuerySnapshot snapshot = await _firestore.collection('note_b').get();

      //! QuerySnapshot의 docs의 여러 문서를 map돌면서 Model화
      List<ExampleModel> result =
          snapshot.docs.map((e) => ExampleModel.fromFirebase(e)).toList();

      //! 성공 케이스
      return Right(result);
    } catch (e) {
      //! Left는 실패한 케이스 결과값이다.
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<ExampleModel>>>
      getExampleModelByIsFavorited() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('note_b')
          .where('is_favorited', isEqualTo: true)
          .get();

      List<ExampleModel> result =
          snapshot.docs.map((e) => ExampleModel.fromFirebase(e)).toList();

      //! 성공 케이스
      return Right(result);
    } catch (e) {
      //! Left는 실패한 케이스 결과값이다.
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> toggleFavorite(
      {required ExampleModel updatedModel}) async {
    try {
      await _firestore
          .collection('note_b')
          .doc(updatedModel.id)
          .update(updatedModel.toJson());

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> setNoteBDoc(
      {required ExampleModel setModel}) async {
    DocumentReference doc = _firestore.collection("note_b").doc();

    try {
      await doc.set({
        'id': doc.id,
        'title': setModel.title,
        'content': setModel.content,
        'created_at': Timestamp.fromDate(DateTime.now()),
        'is_favorited': false,
      });

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
