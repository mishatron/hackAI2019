import 'package:hackai/src/core/api/dio_manager.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource.dart';
import 'package:hackai/src/domain/ClientModel.dart';


class RemoteDataSourceImpl extends RemoteDataSource {


  @override
  Future<ClientModel> getUser(String id) async {
    return await DioManager().get('v1/users/byId/' + id).then((response) {
      ClientModel model;
      if (response.data['data'] != null)
        model = ClientModel.fromJson(response.data['data']);
      //return APIResponse.fromJsonMap(response.data, model);
    });
  }

//  @override
//  Future<Nothing> createUser(ClientModel model) async {
//    return await DioManager()
//        .post('v1/users/create/' + model.id + '/', body: model.toJson())
//        .then((response) {
//      Nothing model;
//      if (response.data['data'] != null)
//        model = Nothing.fromJsonMap(response.data['data']);
//     // return APIResponse.fromJsonMap(response.data, model);
//    });
//  }
}
