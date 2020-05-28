import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackai/src/data/repositories/ml/ml_repository.dart';
import 'package:hackai/src/domain/data_model.dart';

class MLRepositoryImpl extends MLRepository {
  @override
  Future<String> uploadData(DataModel model) async {
    return await Firestore.instance
        .collection("data")
        .add(model.toJson())
        .then((value) {
      return value.documentID;
    });
  }
}
