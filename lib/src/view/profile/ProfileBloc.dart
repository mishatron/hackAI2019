import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackai/src/core/bloc/base_bloc.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/content_loading_state.dart';
import 'package:hackai/src/core/bloc/error_state.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource.dart';
import 'package:hackai/src/domain/ClientModel.dart';

class ProfileLoadedState extends BaseBlocState {
  ClientModel model;
  ProfileLoadedState(this.model);
}

class ProfileBloc extends BaseBloc<BaseBlocState, DoubleBlocState> {

  RemoteDataSource _remoteDataSource;


  ProfileBloc(){
    getUser();
  }

  @override
  DoubleBlocState get initialState =>
      DoubleBlocState(ContentLoadingState(), null);

  void getUser() async {
    try{
      var user = await FirebaseAuth.instance.currentUser();
      var userAPI = await _remoteDataSource.getUser(user.uid);
      add(ProfileLoadedState(userAPI));
    }
    catch(err){
      add(ErrorState(err));
    }

  }

}
