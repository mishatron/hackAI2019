import 'package:hackai/src/core/base_repository.dart';
import 'package:hackai/src/domain/ClientModel.dart';

abstract class AuthRepository extends BaseRepository{

  Future<bool> getIsFirstLaunch();


  Future<bool> setIsSecondLaunch();


  Future<void> createUser(ClientModel model);


  Future<ClientModel> getUser();

}