import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackai/src/core/base_presenter.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource.dart';
import 'package:hackai/src/domain/ClientModel.dart';
import 'package:http/http.dart' as http;
import 'package:hackai/main.dart';

import 'package:hackai/src/di/dependency_injection.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';



abstract class AuthContract extends BaseContract {
  void onLogin();
}

class AuthPresenter extends BasePresenter {
  AuthContract _view;
  RemoteDataSource _remoteDataSource;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  AuthPresenter(this._view) {
    _remoteDataSource = injector.get();
  }

  void makeGoogleLogin() async {
    _view.onShowProgress();
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    if (user != null) {
      var flNames = user.displayName.split(' ');

      ClientModel model = new ClientModel();
      model.id = user.uid;
      model.name = user.displayName;
      model.email = user.email;
      model.phone = user.phoneNumber;

      CoreApp.clientModel = await checkUserExistence(user.uid, model);
      _view.onHideProgress();
      _view.onLogin();
    } else {
      _view.onHideProgress();
    }
  }

  void handleFacebookSignIn() async {
    _view.onShowProgress();
    final FacebookLoginResult result = await facebookSignIn
        .logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=email,picture.height(512)&access_token=${result.accessToken.token}');

        var profile = json.decode(graphResponse.body);

        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        if (user != null) {
          var flNames = user.displayName.split(' ');
          ClientModel model = new ClientModel();
          model.id = user.uid;
          model.email = profile["email"];
          model.phone = user.phoneNumber;
          model.name = user.displayName;
          CoreApp.clientModel = await checkUserExistence(user.uid, model);
          _view.onHideProgress();
          _view.onLogin();
        } else
          _view.onHideProgress();
        break;
      case FacebookLoginStatus.cancelledByUser:
        _view.onHideProgress();
       // _view.onShowMessage(login_canceled_msg);
        break;
      case FacebookLoginStatus.error:
        _view.onHideProgress();
        _view.onError(result.errorMessage);
        break;
    }

    _view.onHideProgress();
  }

  Future<ClientModel> checkUserExistence(
      String id, ClientModel curModel) async {
    var model = await _remoteDataSource.getUser(id);
    if (model == null) {
      await _remoteDataSource.createUser(curModel);
      return curModel;
    } else {
      return model;
    }
  }
}
