import 'package:hackai/src/core/api/dio_manager.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource.dart';
import 'package:hackai/src/domain/ClientModel.dart';


class RemoteDataSourceImpl extends RemoteDataSource {


  @override
  Future<ClientModel> getUser(String id) async {
    return await DioManager().get('user/' + id).then((response) {
      ClientModel model;
      if (response.data['data'] != null)
        model = ClientModel.fromJson(response.data['data']);
      return model;
    });
  }

  @override
  Future<ClientModel> createUser(ClientModel model) async {
    return await DioManager()
        .post('user/' , body: model.toJson())
        .then((response) {
      return model;
    });
  }
}
