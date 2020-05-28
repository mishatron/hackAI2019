import 'package:hackai/src/core/base_repository.dart';
import 'package:hackai/src/domain/data_model.dart';

abstract class MLRepository extends BaseRepository{
  Future<String> uploadData(DataModel model);
}