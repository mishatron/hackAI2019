
import 'package:hackai/src/domain/ClientModel.dart';

abstract class RemoteDataSource{

  Future<ClientModel> getUser(String id);
  //Future<Nothing> createUser(ClientModel model);
}