
import 'package:hackai/src/domain/ClientModel.dart';

abstract class RemoteDataSource{

  Future<ClientModel> getUser(String id);
  Future<ClientModel> createUser(ClientModel model);
}