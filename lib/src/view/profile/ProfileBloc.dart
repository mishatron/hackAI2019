import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackai/src/core/bloc/base_bloc.dart';
import 'package:hackai/src/core/bloc/base_bloc_state.dart';
import 'package:hackai/src/core/bloc/content_loading_state.dart';
import 'package:hackai/src/core/bloc/error_state.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:hackai/src/domain/ClientModel.dart';

class ProfileLoadedState extends BaseBlocState {
  ClientModel model;

  ProfileLoadedState(this.model);
}

class ProfileBloc extends BaseBloc<BaseBlocState, DoubleBlocState> {
  RemoteDataSource _remoteDataSource = injector.get();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookSignIn = FacebookLogin();

  ProfileBloc() {
    _remoteDataSource = injector.get();
    getUser();
  }

  @override
  DoubleBlocState get initialState =>
      DoubleBlocState(ContentLoadingState(), null);

  void getUser() async {
    try {
      var user = await FirebaseAuth.instance.currentUser();

      add(ProfileLoadedState(ClientModel(
          id: user.uid,
          email: "mishatron98gmail.com",
          phone: "+380954150177",
          name: "Михайло",
          surname: "Кренцін",
          photoUrl: "")));
//      var user = await FirebaseAuth.instance.currentUser();
//      var userAPI = await _remoteDataSource.getUser(user.uid);
//      add(ProfileLoadedState(userAPI));
    } catch (err) {
      print(err);
      add(ErrorState(err));
    }
  }

  Future<Null> logout() async {
//    await _repository.deleteFCM(MainApp.clientModel.id, fcmToken);
    await FirebaseAuth.instance.signOut();
    await _facebookSignIn.logOut();
    return await _googleSignIn.signOut();
  }
}
